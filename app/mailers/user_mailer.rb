class UserMailer < ApplicationMailer
  default from: '"Shift Heroes de JoinCodingNow.com" <support@joincodingnow.com>'
  
  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(user.activation_token)
    mail(to: @user.email, subject: "Lien d'activation ton compte")
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(to: @user.email, subject: 'Ton compte est activé')
  end

  def reset_password_email(user)
    @user = user
    @url  = reset_password_url(token: @user.reset_password_token)
    mail(to: @user.email, subject: 'Réinitialiser ton mot de passe')
  end

end
