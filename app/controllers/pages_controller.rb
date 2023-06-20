class PagesController < ApplicationController
  def home
    redirect_to plannings_path if current_user
  end

  def api
  end
end
