class Api::V1::AuthenticatedController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    protect_from_forgery with: :null_session

    before_action :authenticate
    before_action :check_api_limit
    before_action :log_api_request

    attr_reader :current_user, :current_api_token
    
    def authenticate
        authenticate_user_with_token || handle_bad_authentication
    end

    private
    
    def curl_used
        request.user_agent.include?('curl')
    end

    def python_used
        request.user_agent.include?('python')
    end

    def authenticate_user_with_token
        authenticate_with_http_token do |token, options|
            @current_api_token = ApiToken.where(active: true).find_by(token: token)
            @current_user = @current_api_token&.user
        end
    end

    def check_api_limit
        current_user.record_achievement("20_api_calls_in_10_seconds") if current_user.api_requests_within_last_10_seconds >= 20
        
        if current_user.api_limit_exceeded?
            current_user.record_achievement("api_limit_reached")
            render json: { message: "API limit exceeded " }, status: :too_many_requests
        end
    end

    def handle_bad_authentication
        render json: { message: "Bad credentials" }, status: :unauthorized
    end

    def handle_not_found
        render json: { message: "Not found" }, status: :not_found
    end

    def log_api_request
        current_user.api_requests&.create!(path: request.path, method: request.method, user_agent: request.user_agent)
        current_user.record_achievement("first_successful_api_call")

        if chained_api_calls_without_curl?
            current_user.record_achievement("chained_api_calls_without_curl")
        end
    end

    def chained_api_calls_without_curl?
        last_3_requests = current_user.api_requests.order(created_at: :desc).limit(3)
        return false unless last_3_requests.count == 3 && last_3_requests.all? { |request| !request.user_agent.include?("curl") }
    
        last_3_requests[0].path =~ %r{^/api/v1/plannings/\w+/shifts/\w+/reservations$} && last_3_requests[0].method == "POST" &&
        last_3_requests[1].path =~ %r{^/api/v1/plannings/\w+/shifts$} && last_3_requests[1].method == "GET" &&
        last_3_requests[2].path == "/api/v1/plannings" && last_3_requests[2].method == "GET"
    end
end