class AddResourcesToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :resources, :jsonb
  end
end
