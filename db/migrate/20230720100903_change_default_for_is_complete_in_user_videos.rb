class ChangeDefaultForIsCompleteInUserVideos < ActiveRecord::Migration[7.0]
  def change
    change_column_default :user_videos, :is_complete, from: nil, to: false
  end
end
