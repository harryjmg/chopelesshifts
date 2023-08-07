class AddCustomIdToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :custom_id, :string
  end
end
