class AddPublishedAtToPlannings < ActiveRecord::Migration[7.0]
  def change
    add_column :plannings, :published_at, :datetime
  end
end
