class ApplicationController < ActionController::Base
    before_action :set_notifications
    
    private
    def not_authenticated
        redirect_to login_path, alert: "Il faut être connecté pour accéder à cette page"
    end

    def set_notifications
        if current_user
            @new_achievements_count = current_user.user_achievements.where(seen: false).count
        end
    end
end
