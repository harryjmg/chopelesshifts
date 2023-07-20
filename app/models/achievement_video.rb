class AchievementVideo < ApplicationRecord
    belongs_to :achievement
    belongs_to :video

    validates :achievement_id, presence: true
    validates :video_id, presence: true
end