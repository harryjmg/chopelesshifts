class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  after_create :check_if_all_achievements_for_video

  def check_if_all_achievements_for_video
    video = self.achievement.video

    if video && user.has_all_achievements_for(video)
      user.complete_video(video)
      user.unlock_video(video.next_video)
    end
  end
end
