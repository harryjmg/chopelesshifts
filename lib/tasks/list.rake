namespace :list do
    desc "Add to mailing list all users who have completed the onboarding"

    task update: :environment do
        User.where(added_to_list: false, onboarded: true).each do |user|
            response = HTTParty.post("https://hook.eu1.make.com/97b6fgu31virfopvd7lisofsaxflvgpt", 
                :body => { :email => user.email, :first_name => user.first_name }.to_json,
                :headers => { 'Content-Type' => 'application/json' }
            )
            
            if response.success?
                user.update(added_to_list: true)
            else
                puts "Failed to add user #{user.id} to mailing list"
            end
        end
        puts "Contacts added to list."

        # Users who have completed the last achievement
        # puts "Getting users who have completed the last achievement..."
        # User.where(added_to_list: true, onboarded: true).each do |user|
        #     if user.achievements.include?(Achievement.find_by(key: "booked_14_slots_via_api"))
        #         response = HTTParty.post("https://hook.eu1.make.com/97b6fgu31virfopvd7lisofsaxflvgpt",
        #             :body => { :email => user.email, :first_name => user.first_name }.to_json,
        #             :headers => { 'Content-Type' => 'application/json' }
        #         )
        #         if response.success?
        #             puts "User #{user.id} added to list"
        #         else
        #             puts "Failed to add user #{user.id} to mailing list"
        #         end
        #     end
        # end
    end

    
end
