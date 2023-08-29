namespace :clean do
    desc "Add to mailing list all users who have completed the onboarding"

    task api_requests: :environment do
        puts "Cleaning user actions..."
        User.all.each do |user|
            if (user.api_requests.count > 100)
                print (".")
            end
            user.api_requests.order("created_at DESC").offset(100).destroy_all
        end
        puts ""
        puts "Done."
    end

    task unlock_blocked_users: :environment do
        User.all.each do |u|
            if u.user_videos.any? && u.last_video_accessible != Video.find_by(custom_id: "congratulations")
                # Check if the user has completed the last_video_accessible
                if u.user_videos.find_by(video: u.last_video_accessible).is_complete
                    puts "Unlocking next video for #{u.email}"
                    u.complete_video(u.last_video_accessible)
                end
            end
        end
    end
end
