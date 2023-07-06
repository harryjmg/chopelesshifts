namespace :planning do
    desc "Create, publish and simulate human users by progressively filling up planning slots"

    task daily: :environment do
        create_and_fill_planning('daily', 180, 10, 1, 5)  # Sleep 1 second between each fill, and fill 5 slots each time
    end

    task weekly: :environment do
        create_and_fill_planning('weekly', 60, 4, 1, 10)  # Sleep 1 second between each fill, and fill 10 slots each time
    end

    def create_and_fill_planning(type, times_to_fill, sleep_before_fill, sleep_between_fill, num_slots_to_fill)
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
            fill_shifts(planning, num_slots_to_fill)
            sleep sleep_between_fill
        end

        puts "Filling all remaining shifts."
        full_all_shifts(planning)

        puts "Task to create and fill #{type} planning finished."
    end

    def fill_shifts(planning, num_slots_to_fill)
        available_shifts = planning.shifts.where("seats_taken < seats")
        
        shifts_to_reserve = available_shifts.sample(num_slots_to_fill)
        
        shifts_to_reserve.each do |shift|
            next if shift.seats_taken == shift.seats
            puts "Reserving a seat in shift #{shift.id}."
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
