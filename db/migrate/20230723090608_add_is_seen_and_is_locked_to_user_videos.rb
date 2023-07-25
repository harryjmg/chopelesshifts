class AddIsSeenAndIsLockedToUserVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :user_videos, :is_seen, :boolean, default: false
    add_column :user_videos, :is_locked, :boolean, default: false
  end
end
