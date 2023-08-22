class AddUserToMailingListJob < ApplicationJob
  queue_as :default

  def perform(user)
    response = HTTParty.post("https://hook.eu1.make.com/97b6fgu31virfopvd7lisofsaxflvgpt", 
      :body => { :email => user.email,
          :first_name => user.first_name
      }.to_json,
      :headers => { 'Content-Type' => 'application/json' }
    )
    
    if response.success?
        user.update(added_to_list: true)
    else
        puts "Failed to add user #{user.id} to mailing list"
    end
  end
end
