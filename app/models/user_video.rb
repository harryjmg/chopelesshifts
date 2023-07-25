class UserVideo < ApplicationRecord
    belongs_to :user
    belongs_to :video

    validates :user_id, presence: true
    validates :video_id, presence: true

    after_update :check_and_unlock_next_video

    def check_and_unlock_next_video
        if self.is_complete
            self.user.user_videos.find_or_create_by(video: self.video.next_video)
        end
    end
end