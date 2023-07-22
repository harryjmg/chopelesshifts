class UserSessionsController < ApplicationController

  def create
    @user = login(params[:email]&.downcase, params[:password], params[:remember_me])

    if @user
      redirect_to(:plannings, notice: 'Connexion réussie')
    else
      flash.now[:alert] = 'Connexion échouée'
      render action: 'new', status: :unprocessable_entity
    end
  end

  def destroy
    current_user.forget_me!
    logout
    redirect_to(:root, notice: 'Déconnexion réussie')
  end
end
