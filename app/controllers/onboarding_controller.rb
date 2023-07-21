class OnboardingController < ApplicationController
    before_action :require_login
    
    def onboarding
    end

    def onboard
        current_user.update(is_onboarded: true)
        redirect_to root_path
    end

    def unboard
        current_user.update(is_onboarded: false)
        redirect_to root_path
    end

end