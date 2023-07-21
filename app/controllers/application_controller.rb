class ApplicationController < ActionController::Base
    before_action :set_notifications
    
    private

    def check_onboarding
        if current_user && !current_user.is_onboarded && !request.path.start_with?('/onboarding')
            redirect_to onboarding_path, alert: "Hep hep hep, il faut d'abord regarder cette vidéo !"
        end
    end

    def not_authenticated
        redirect_to login_path, alert: "Il faut être connecté pour accéder à cette page"
    end

    def set_notifications
        if current_user
            @new_achievements_count = current_user.user_achievements.where(seen: false).count
            @new_videos_count = current_user.user_videos.where(is_complete: false).count
        end
    end
end
