class AddCurrentLevelToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_level, :integer, default: 0
  end
end
