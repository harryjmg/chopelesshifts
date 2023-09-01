class AddHelpingVideoUrlToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :helping_video_url, :string
  end
end
