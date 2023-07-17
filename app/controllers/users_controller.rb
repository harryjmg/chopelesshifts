class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy, :achievements]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(:root, notice: "Lien d'activation envoyé à cet email: #{@user.email}")
    else
      flash.now[:alert] = "L'utilisateur n'a pas pu être créé : #{@user.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      auto_login(@user)
      @user.record_achievement('account_activation')
      redirect_to(plannings_path, :notice => 'Ton compte est activé.')
    else
      not_authenticated
    end
  end

  def achievements
    @user_achievements = current_user.user_achievements.includes(:achievement)
  
    @new_achievement_ids = @user_achievements.where(seen: false).pluck(:achievement_id)
  
    @new_achievements = Achievement.where(id: @new_achievement_ids).order(created_at: :desc)
    @obtained_achievements = Achievement.where(id: @user_achievements.where.not(id: @new_achievement_ids).pluck(:achievement_id)).order(created_at: :desc)
    @not_obtained_achievements = Achievement.where.not(id: @user_achievements.pluck(:achievement_id))
  
    @achievements = @new_achievements + @obtained_achievements + @not_obtained_achievements

    @total_points = current_user.user_achievements.sum(&:points)
    @max_points = Achievement.sum(&:points)
  
    @user_achievements.where(achievement_id: @new_achievement_ids).update_all(seen: true)
  end
  
  

  private
    def user_params
      params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
    end
end
