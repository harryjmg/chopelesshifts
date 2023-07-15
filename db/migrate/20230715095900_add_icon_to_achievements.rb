class AddIconToAchievements < ActiveRecord::Migration[7.0]
  def change
    add_column :achievements, :icon, :string
  end
end
