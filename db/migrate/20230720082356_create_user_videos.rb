class CreateUserVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_videos do |t|
      t.references :video, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :is_complete

      t.timestamps
    end
  end
end
