class CreateAchievements < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :description
      t.integer :points

      t.timestamps
    end
  end
end
