class ApiTokensController < ApplicationController
    before_action :require_login

    def index
        @api_tokens = current_user.api_tokens
    end

    def create
        @api_token = current_user.api_tokens.create!
        respond_to do |format|
            format.turbo_stream
        end
    end

    def update
        @api_token = current_user.api_tokens.find(params[:id])
        @api_token.update!(active: !@api_token.active)
        respond_to do |format|
            format.turbo_stream
        end
    end
end