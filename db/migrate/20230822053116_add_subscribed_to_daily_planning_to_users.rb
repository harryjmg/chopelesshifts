class AddSubscribedToDailyPlanningToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscribed_to_daily_planning, :boolean, default: false
  end
end
