class AddAchievementsCountToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :achievements_count, :integer
  end
end
