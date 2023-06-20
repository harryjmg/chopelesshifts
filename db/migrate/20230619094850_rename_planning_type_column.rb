class RenamePlanningTypeColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :plannings, :type, :planning_type
  end
end
