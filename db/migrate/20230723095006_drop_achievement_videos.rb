class DropAchievementVideos < ActiveRecord::Migration[7.0]
  def change
    drop_table :achievement_videos
  end
end
