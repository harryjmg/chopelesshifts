class AddIsOnboardedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_onboarded, :boolean, default: false
  end
end
