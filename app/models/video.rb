class Video < ApplicationRecord
    has_many :achievements

    has_many :user_videos, dependent: :destroy
    has_many :users, through: :user_videos

    belongs_to :next_video, class_name: 'Video', optional: true
    belongs_to :previous_video, class_name: 'Video', optional: true
    
    has_one :subsequent_video, class_name: 'Video', foreign_key: 'previous_video_id'
    has_one :preceding_video, class_name: 'Video', foreign_key: 'next_video_id'
end