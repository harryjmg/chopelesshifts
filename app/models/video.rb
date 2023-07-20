class Video < ApplicationRecord
    has_many :achievement_videos
    has_many :achievements, through: :achievement_videos

    has_many :user_videos, dependent: :destroy
    has_many :users, through: :user_videos
end