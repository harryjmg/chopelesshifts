class CreateAchievementVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :achievement_videos do |t|
      t.references :video, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
