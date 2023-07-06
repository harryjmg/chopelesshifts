class Shift < ApplicationRecord
  include Hashid::Rails

  belongs_to :planning

  has_many :reservations
  has_many :users, through: :reservations

  after_initialize :init

  def init
    self.seats_taken ||= 0
  end
end
