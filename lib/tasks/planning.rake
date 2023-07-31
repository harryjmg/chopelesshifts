namespace :planning do
    desc "Create, publish and simulate human users by progressively filling up planning slots"

    task daily: :environment do
        User.all.each { |user| create_daily_planning(user) }
    end

    task weekly_force: :environment do
        create_and_fill_planning('weekly', 30, 1, 0.5, 1)
    end

    task weekly: :environment do
        if Time.now.wday == 6 # Saturday
            create_and_fill_planning("weekly", 60, 2, 1, 0.20)
        else
            puts "Today is not Saturday. Aborting."
        end
    end

    task clean: :environment do
        # Archive plannings older than 1 month
        puts "Archiving plannings older than 3 month..."
        Planning.where("published_at < ?", 3.month.ago).where(planning_type: 'weekly').update_all(state: 'archived')
        puts "Done."
    end

    def create_daily_planning(user)
        puts "Starting task to create daily planning for user #{user.id}."
        
        user.plannings.where(planning_type: 'daily', state: 'available').update_all(state: 'closed')

        planning = Planning.create_planning('daily', user)
        planning.publish
    end

    def create_and_fill_planning(type, times_to_fill, sleep_before_fill, sleep_between_fill, percent_to_fill)
        puts "Starting task to create and fill #{type} planning."

        puts "Setting all #{type} plannings to 'closed'."
        Planning.where(planning_type: type, state: 'available').update_all(state: 'closed')

        puts "Creating a new #{type} planning."
        planning = Planning.create_planning(type)

        puts "Publishing the new #{type} planning."
        planning.publish

        puts "Waiting for #{sleep_before_fill} seconds."
        sleep sleep_before_fill

        puts "Starting to fill shifts."
        times_to_fill.times do
            fill_shifts(planning, percent_to_fill)
            sleep sleep_between_fill
        end
        puts ""

        puts "Filling all remaining shifts."
        full_all_shifts(planning)

        puts "Task to create and fill #{type} planning finished."
    end

    def fill_shifts(planning, percent_to_fill)
        available_shifts = planning.shifts.where("seats_taken < seats")

        num_slots_to_fill = (available_shifts.sum(:seats) * percent_to_fill).ceil
        shifts_to_reserve = available_shifts.sample(num_slots_to_fill)

        shifts_to_reserve.each do |shift|
            next if shift.seats_taken == shift.seats
            print "."
            shift.update(seats_taken: shift.seats_taken + 1)
        end
    end

    def full_all_shifts(planning)
        available_shifts = planning.shifts.where("seats_taken < seats")
        available_shifts.each do |shift|
            puts "Filling all remaining seats in shift #{shift.id}."
            shift.update(seats_taken: shift.seats)
        end
    end
end
