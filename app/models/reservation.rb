class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  
  delegate :planning, to: :shift

  validates :user_id, presence: true
  validates :shift_id, presence: true

  validates :shift_id, uniqueness: { scope: :user_id }

  validate :shift_full, on: :create
  validate :planning_available, on: :create
  validate :planning_belongs_to_user, on: :create

  after_create :add_seat_taken
  after_destroy :remove_seat_taken

  def planning_available
    if planning.state != "available"
      errors.add(:base, "This planning is not available")
    end
  end

  def planning_belongs_to_user
    if planning.user != user && planning.planning_type != "weekly"
      errors.add(:base, "This planning does not belong to you")
    end
  end

  def add_seat_taken
    shift.update(seats_taken: shift.seats_taken + 1)
  end

  def remove_seat_taken
    shift.update(seats_taken: shift.seats_taken - 1)
  end

  def shift_full
    if shift.seats_taken >= shift.seats
      errors.add(:base, "This shift is full")
    end
  end

  def duration_in_hours
    (shift.end_hour - shift.start_hour) / 3600
  end

  def to_api_json
    {
      id: id,
      shift_id: shift.hashid
    }
  end
end
