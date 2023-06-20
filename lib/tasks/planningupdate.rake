namespace :planningupdate do
  desc "TODO"
  task permanent: :environment do

  end

  desc "TODO"
  task daily: :environment do

  end

  desc "TODO"
  task weekly: :environment do
    name = "#{Date.today.strftime("%Y S%W")}"
    Planning.create!(name: "Planning #{Date.today.strftime("%Y-%W")}", planning_type: "weekly", state: "published")
  end

  task weekly_next: :environment do
    Planning.last.update(state: "archived")
  end

end
