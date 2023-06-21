class Api::V1::ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    before_action :authenticate
    rescue_from StandardError, with: :render_error_response

    def current_user
        @current_user
    end

    def render_error_response(exception)
        render json: { error: exception.message }, status: :internal_server_error
    end

    private

    def authenticate
        authenticate_or_request_with_http_basic do |email, password|
            user = User.find_by(email: email)
            if user&.valid_password?(password)
                @current_user = user
            else
                render json: { error: "Access denied" }, status: :unauthorized
            end
        end
    end
end