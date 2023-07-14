class UserSessionsController < ApplicationController

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to(:plannings, notice: 'Connexion réussie')
    else
      flash.now[:alert] = 'Connexion échouée'
      render action: 'new', status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: 'Déconnexion réussie')
  end
end
