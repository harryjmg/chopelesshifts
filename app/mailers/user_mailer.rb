class UserMailer < ApplicationMailer
  default from: 'support@shiftheroes.fr'
  
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
end
