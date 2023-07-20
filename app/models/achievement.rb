class Achievement < ApplicationRecord
    has_many :user_achievements, dependent: :destroy
    has_many :users, through: :user_achievements

    has_many :achievement_videos, dependent: :destroy
    has_many :videos, through: :achievement_videos

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
end
