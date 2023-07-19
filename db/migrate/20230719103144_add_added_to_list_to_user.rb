class AddAddedToListToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :added_to_list, :boolean, default: false
  end
end
