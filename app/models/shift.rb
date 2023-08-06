class Shift < ApplicationRecord
  include Hashid::Rails

  belongs_to :planning

  has_many :reservations
  has_many :users, through: :reservations

  after_initialize :init

  def init
    self.seats_taken ||= 0
  end

  def to_api_json
    {
      id: hashid,
      day: day,
      start_hour: start_hour,
      end_hour: end_hour,
      seats: seats,
      seats_taken: seats_taken
    }
  end
end
