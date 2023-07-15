class AddKeyToAchievements < ActiveRecord::Migration[7.0]
  def change
    add_column :achievements, :key, :string
  end
end
