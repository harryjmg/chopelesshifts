class Planning < ApplicationRecord
    has_many :shifts
    has_many :reservations, through: :shifts
    has_many :users, through: :reservations

    validates :name, presence: true
    validates :planning_type, presence: true
    validates :state, presence: true
end
