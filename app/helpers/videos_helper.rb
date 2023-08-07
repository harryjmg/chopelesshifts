module VideosHelper
    def video_states(video, current_video)
        user_video = UserVideo.find_by(user: current_user, video: video)

        states = []

        if user_video.nil?
            states << :locked
        elsif user_video.is_complete
            states << :complete
        end

        if current_video == video
            states << :active
        end

        if user_video && !user_video.is_complete
            states << :in_progress
        end

        states
    end

    def video_status_class(video, current_video)
        states = video_states(video, current_video)
        
        classes = []

        classes << "playlist_badge"

        if states.include?(:complete)
            classes << "success"
        elsif states.include?(:in_progress)
            classes << "warning"
        end

        classes.join(" ")
    end

    def video_title_class(video, current_video)
        states = video_states(video, current_video)

        classes = []

        classes << "playlist_title"

        if states.include?(:complete) && !states.include?(:active)
            classes << "text-decoration-line-through"
        end

        if states.include?(:active)
            classes << "text-dark"
        elsif states.include?(:in_progress)
            classes << "text-dark text-opacity-50"
        else
            classes << "text-dark text-opacity-25"
        end

        classes.join(" ")
    end

    def class_for_achievement(user_achievement)
        if user_achievement
            "achievement-completed"
        else
            "achievement-incomplete text-muted"
        end
    end
    
    def icon_class_for_achievement(user_achievement)
        if user_achievement
            "fa-regular fa-circle-check"
        else
            "fa-regular fa-circle fa-fade"
        end
    end

end