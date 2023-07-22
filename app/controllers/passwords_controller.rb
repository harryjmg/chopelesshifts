class PasswordsController < ApplicationController

    def forgot_password ; end

    def send_password_reset_instructions
        @user = User.find_by_email(params[:email]&.downcase)
        @user.deliver_reset_password_instructions! if @user
        redirect_to root_path, notice: "Normalement, tu as reçu un email avec un lien pour changer ton mot de passe"
    end

    def reset_password
        @token = params[:token]
    end

    def update_password
        @token = params[:token]
        @user = User.load_from_reset_password_token(@token)

        if @user.blank?
            not_authenticated
            return
        end

        if request.patch?
            if @user.change_password!(params[:user][:password])
                auto_login(@user)
                redirect_to root_path, notice: "Ton mot de passe a été changé avec succès !"
            else
                flash.now[:alert] = "Ton mot de passe n'a pas pu être changé : #{@user.errors.full_messages.join(', ')}"
                render action: 'reset_password'
            end
        end
    end
end