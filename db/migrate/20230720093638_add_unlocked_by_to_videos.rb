class AddUnlockedByToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :unlocked_by, :string
  end
end
