class Achievement < ApplicationRecord
    belongs_to :video, counter_cache: true, optional: true
    
    has_many :user_achievements, dependent: :destroy
    has_many :users, through: :user_achievements

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
end
