class AddNextVideoAndPreviousVideoToVideos < ActiveRecord::Migration[7.0]
  def change
    add_reference :videos, :next_video, foreign_key: { to_table: :videos }
    add_reference :videos, :previous_video, foreign_key: { to_table: :videos }
  end
end
