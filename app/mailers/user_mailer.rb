class UserMailer < ApplicationMailer
  default from: 'support@joincodingnow.com'
  
  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(user.activation_token)
    mail(to: @user.email, subject: 'Activate your account')
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(to: @user.email, subject: 'Your account is now activated')
  end
end
