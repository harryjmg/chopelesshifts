class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.references :planning, null: false, foreign_key: true
      t.string :day
      t.string :start_hour
      t.string :end_hour
      t.integer :seats

      t.timestamps
    end
  end
end
