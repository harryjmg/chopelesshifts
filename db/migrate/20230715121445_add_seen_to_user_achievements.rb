class AddSeenToUserAchievements < ActiveRecord::Migration[7.0]
  def change
    add_column :user_achievements, :seen, :boolean, default: false
  end
end
