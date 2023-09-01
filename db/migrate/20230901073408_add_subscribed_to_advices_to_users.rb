class AddSubscribedToAdvicesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscribed_to_advices, :boolean, default: true
  end
end
