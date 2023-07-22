namespace :list do
    desc "Add to mailing list all users who have completed the onboarding"

    task update: :environment do
        add_to_list(User.find_by(email: "harry.gueguen@gmail.com"))
        # User.where(added_to_list: false, is_onboarded: true).each do |user|
        #     add_to_list(user)
        # end
        puts "Contacts added to list."
    end

    def add_to_list(user)
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

    
end
