class AddSeatsTakenToShifts < ActiveRecord::Migration[7.0]
  def change
    add_column :shifts, :seats_taken, :integer
  end
end
