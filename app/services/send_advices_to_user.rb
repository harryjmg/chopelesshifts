require 'sendinblue'

class SendAdvicesToUserService
    def initialize(user_id)
        @user = User.find(user_id)
    end

    def send_advice(level, reminder_count)
        template_id = select_template_id(level, reminder_count)
        $mixpanel.track(@user.email, "Shift Heroes - Advices sent", { level: level, reminder_count: reminder_count })
        send_email(template_id)
    end

    private

    def select_template_id(level, reminder_count)

        templates = [
            [195, 196, 197, 198, 199, 200, 201, 201, 201, 201],  # Aide pour la vidéo 1 (Hello API)
            [195, 196, 197, 198, 199, 200, 201, 201, 201, 201],  # Aide pour la vidéo 2
            [195, 196, 197, 198, 199, 200, 201, 201, 201, 201], # Pour vidéo 3
            [195, 196, 197, 198, 199, 200, 201, 201, 201, 201], # Pour vidéo 4
            [195, 196, 197, 198, 199, 200, 201, 201, 201, 201], # Pour vidéo 5
            [195, 196, 197, 198, 199, 200, 201, 201, 201, 201], # Pour vidéo 6
            [119, 119, 119, 119, 119, 119, 119, 119, 119, 119]  # Pour vidéo 7 (congratulations)
        ]
        
        return templates[level][reminder_count]
    end

    def send_email(template_id)
        api_instance = SibApiV3Sdk::TransactionalEmailsApi.new
        send_smtp_email = SibApiV3Sdk::SendSmtpEmail.new(
            from: { email: 'support@joincodingnow.com',
                    name: 'Harry Jmg' },
            to: [{ email: @user.email }],
            params: { "HELPING_VIDEO_URL" => get_helping_video_url},
            templateId: template_id
        )
        
        api_instance.send_transac_email(send_smtp_email)
    end

    def get_helping_video_url
        current_video = @user.last_video_accessible
        helping_video_url = current_video.helping_video_url
    end
end
