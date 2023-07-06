class ChangeShiftsStartAndEndHourTypes < ActiveRecord::Migration[7.0]
  def up
    change_column :shifts, :start_hour, 'time USING start_hour::time without time zone'
    change_column :shifts, :end_hour, 'time USING end_hour::time without time zone'
  end
  
  def down
    change_column :shifts, :start_hour, :string
    change_column :shifts, :end_hour, :string
  end
end
