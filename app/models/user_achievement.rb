class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  def points
    self.achievement.points
  end
end
