class PagesController < ApplicationController
  def home
    redirect_to plannings_path if current_user
  end
  
  def dashboard; end

  def api
  end
end
