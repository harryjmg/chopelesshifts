class AddPositionToAchievements < ActiveRecord::Migration[7.0]
  def change
    add_column :achievements, :position, :integer
  end
end
