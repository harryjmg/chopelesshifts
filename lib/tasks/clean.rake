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
end
