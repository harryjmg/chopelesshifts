class AddVideoToAchievements < ActiveRecord::Migration[7.0]
  def change
    add_reference :achievements, :video, null: true, foreign_key: true
  end
end
