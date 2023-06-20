class Shift < ApplicationRecord
  include Hashid::Rails

  belongs_to :planning

  has_many :reservations
  has_many :users, through: :reservation
end
