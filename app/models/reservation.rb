class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  
  delegate :planning, to: :shift

  validates :user_id, presence: true
  validates :shift_id, presence: true

  validates :shift_id, uniqueness: { scope: :user_id }

  validate :shift_full, on: :create

  after_create :add_seat_taken
  after_destroy :remove_seat_taken

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
end
