class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  
  delegate :planning, to: :shift

  validates :user_id, presence: true
  validates :shift_id, presence: true

  validates :shift_id, uniqueness: { scope: :user_id }
end
