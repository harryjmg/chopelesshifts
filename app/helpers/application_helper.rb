module ApplicationHelper
    def button_active_to(name = nil, options = nil, html_options = nil, &block)
        html_options = {} if html_options.nil?
        if current_page?(options)
            html_options[:class] = "#{html_options[:class]} active"
        else
            html_options[:class] = "#{html_options[:class]} inactive"
        end
        button_to(name, options, html_options, &block)
    end

    def button_active_to_block(options = nil, html_options = nil, &block)
        html_options = {} if html_options.nil?
        if current_page?(options)
            html_options[:class] = "#{html_options[:class]} active"
        else
            html_options[:class] = "#{html_options[:class]} inactive"
        end
        button_to(options, html_options, &block)
    end

    def evaluate_performance(count)
        comments = [
            ["(nul)", "(bouuh)", "(claqué)", "(à chier)", "(pitoyable)", "(nullos)", "(la honte)"],
            ["(pas terrible)", "(bof)", "(moyen)", "(pas fou)", "(pas top)", "(passable)"],
            ["(presque!)", "(respectable!)", "(c'est ton max ?)"],
            ["(tu es l'élu)", "(t'as géré)", "(tu triches ?)", "(génie)", "(exceptionnel)", "(wow)", "(godlike)", "(incroyable)"]
        ]

        case count
        when 0..4
            comments[0].sample
        when 5..9
            comments[1].sample
        when 10..12
            comments[2].sample
        else
            comments[3].sample
        end
    end

    def bootstrap_class_for(flash_type)
        case flash_type
        when "success"
            "success"
        when "error"
            "danger"
        when "alert"
            "warning"
        when "notice"
            "info"
        else
            flash_type.to_s
        end
    end

    def random_success_message
        messages = [
            "Youyou !",
            "Bravo !",
            "Tout neuf !",
            "Bouyaka !",
            "BLUT BLUT !",
            "Gangsta !"
        ].sample
    end

    def video_status_class(video, current_video)
        user_video = video.user_videos.where(user: current_user).first
        return "locked" unless user_video
        if !user_video.is_seen || !user_video.is_complete
            "bg-rainbow rainbow-text"
        else
            "default"
        end
    end
end
