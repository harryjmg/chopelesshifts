class ApplicationController < ActionController::Base
    private
    def not_authenticated
        redirect_to login_path, alert: "Il faut être connecté pour accéder à cette page"
    end
end
