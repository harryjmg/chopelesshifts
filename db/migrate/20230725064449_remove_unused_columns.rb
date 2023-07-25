class RemoveUnusedColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :achievements, :points, :integer
    remove_column :achievements, :position, :integer

    remove_column :reservations, :speed_in_ms, :integer

    drop_table :user_logs
  end
end
