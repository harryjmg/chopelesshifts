class AddUserAgentToApiRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :api_requests, :user_agent, :string
  end
end
