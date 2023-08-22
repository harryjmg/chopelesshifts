class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :toggle_daily_planning_subscription]
  before_action :check_onboarding, only: [:show]

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
      @user.user_videos.find_or_create_by(video: Video.first)
      @user.track_action("Shift Heroes - Account activated")

      redirect_to(videos_path, :notice => 'Ton compte est activé.')
    else
      not_authenticated
    end
  end

  def toggle_subscription
    current_user.update(subscribed_to_daily_planning: !current_user.subscribed_to_daily_planning)
    @subscribed_to_daily_planning = current_user.subscribed_to_daily_planning
    
    respond_to do |format|
      format.turbo_stream
    end
  end  

  private
    def user_params
      params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
    end
end
