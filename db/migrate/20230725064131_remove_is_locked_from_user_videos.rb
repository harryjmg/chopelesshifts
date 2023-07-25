class RemoveIsLockedFromUserVideos < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_videos, :is_locked, :boolean
  end
end
