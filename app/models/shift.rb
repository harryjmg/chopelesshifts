class Shift < ApplicationRecord
  include Hashid::Rails

  belongs_to :planning

  has_many :reservations
  has_many :users, through: :reservations

  after_initialize :init

  def init
    self.seats_taken ||= 0
  end

  def duration
    (end_hour - start_hour).to_i
  end

  def duration_in_hours
    (duration / 60.0 / 60).round(2)
  end
end
