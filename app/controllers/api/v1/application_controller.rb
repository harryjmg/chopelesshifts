class Api::V1::ApplicationController < ActionController::API
    def current_user
        @current_user ||= login_from_params
    end

    rescue_from StandardError, with: :render_error_response

    def render_error_response(exception)
        render json: { error: exception.message }, status: :internal_server_error
    end

    private

    def login_from_params
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
            user
        else
            render json: { error: "Invalid email or password" }, status: :unauthorized
        end
    end
end