namespace :all_users do
    include Sidekiq::worker
    
    task unlock_blocked_users: :environment do
        desc "Unlock the next video for all users who have completed the previous one but."
        User.all.each do |u|
            if u.user_videos.any? && u.last_video_accessible != Video.find_by(custom_id: "congratulations")
                # Check if the user has completed the last_video_accessible
                if u.user_videos.find_by(video: u.last_video_accessible).is_complete
                    puts "Unlocking next video for #{u.email}"
                    if u.complete_video(u.last_video_accessible)
                        puts "- Done."
                    else
                        u.user_videos.find_by(video: u.last_video_accessible).update(is_complete: false)
                        puts "- Uncomplete video because not completed all achievements"
                    end
                end
            end
        end
    end

    task initialize_advices: :environment do
        desc "Initialize advices for all users"

        User.where(activation_state: "active").each do |u|
            u.not_left_behind
        end
    end
    
end
