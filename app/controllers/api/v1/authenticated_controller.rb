class Api::V1::AuthenticatedController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    before_action :authenticate
    rescue_from StandardError, with: :render_error_response
    rescue_from ActionController::RoutingError, with: :catch_404

    attr_reader :current_user, :current_api_token

    def catch_404(e)
        render json: { error: 'Page not found' }, status: :not_found
    end
    
    def render_error_response(exception)
        render json: { error: exception.message }, status: :internal_server_error
    end
    
    def authenticate
        authenticate_user_with_token || handle_bad_authentication
    end

    private

    def authenticate_user_with_token
        authenticate_with_http_token do |token, options|
            @current_api_token = ApiToken.where(active: true).find_by(token: token)
            @current_user = @current_api_token&.user
        end
    end

    def handle_bad_authentication
        render json: { message: "Bad credentials" }, status: :unauthorized
    end

end