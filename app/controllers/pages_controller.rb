class PagesController < ApplicationController
  before_action :require_login, only: %i[dashboard instructions api]
  before_action :check_onboarding, only: %i[dashboard instructions api]

  def home
    redirect_to videos_path if current_user
  end
  
  def dashboard; end

  def instructions; end

  def api
  end
end
