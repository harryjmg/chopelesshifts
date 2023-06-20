
# Create 3 plannings
Planning.create!(name: "Planning permanent", planning_type: "permanent", state: "draft")
Planning.create!(name: "Planning journalier", planning_type: "daily", state: "draft")
Planning.create!(name: "Planning hebdomadaire", planning_type: "weekly", state: "draft")

# Create shifts for the planning permanent
planning = Planning.find_by(name: "Planning permanent")
days = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]
days.each do |day|
    planning.shifts.create!(day: day, start_hour: "08:00", end_hour: "14:00", seats: rand(1..10))
    planning.shifts.create!(day: day, start_hour: "14:00", end_hour: "21:00", seats: rand(1..10))
end

# Create shifts for the planning journalier
planning = Planning.find_by(name: "Planning journalier")
days.each do |day|
    planning.shifts.create!(day: day, start_hour: "08:00", end_hour: "14:00", seats: rand(1..10))
    planning.shifts.create!(day: day, start_hour: "14:00", end_hour: "21:00", seats: rand(1..10))
end

# Create shifts for the planning hebdomadaire
planning = Planning.find_by(name: "Planning hebdomadaire")
days.each do |day|
    planning.shifts.create!(day: day, start_hour: "08:00", end_hour: "14:00", seats: rand(1..10))
    planning.shifts.create!(day: day, start_hour: "14:00", end_hour: "21:00", seats: rand(1..10))
end
