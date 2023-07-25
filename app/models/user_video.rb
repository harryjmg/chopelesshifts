class UserVideo < ApplicationRecord
    belongs_to :user
    belongs_to :video

    validates :user_id, presence: true
    validates :video_id, presence: true

    after_update :check_if_complete, if: -> { saved_change_to_is_complete? && is_complete? }

    def check_if_complete
        if self.user.has_all_achievements_for(self.video)
            self.user.user_videos.find_or_create_by(video: self.video.next_video)
        end
    end
end