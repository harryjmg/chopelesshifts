class User < ApplicationRecord
  include Hashid::Rails

  authenticates_with_sorcery! do |config|
    config.submodules = [:remember_me, :activation, :reset_password]
  end

  validates :first_name, presence: true, on: :create
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, on: :create

  validates :email, uniqueness: true

  has_many :reservations, dependent: :destroy
  has_many :shifts, through: :reservations

  has_many :api_tokens, dependent: :destroy
  has_many :api_requests, dependent: :destroy
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  has_many :plannings, class_name: "Planning", dependent: :destroy

  after_create :create_permanent_planning
  after_create :create_daily_planning

  MAX_API_REQUESTS_PER_10_MINUTE = 300

  def api_requests_within_last_10_minutes
    api_requests.where("created_at > ?", 10.minutes.ago).count
  end

  def api_limit_exceeded?
    api_requests_within_last_10_minutes >= MAX_API_REQUESTS_PER_10_MINUTE
  end

  def create_permanent_planning
    planning = Planning.create_planning("permanent", self)
    planning.publish
  end

  def create_daily_planning
    plannings.where(planning_type: "daily", state: "available").update_all(state: "closed")
    planning = Planning.create_planning("daily", self)
    planning.publish
  end

  def record_achievement(key)
    achievement = Achievement.find_by(key: key)  
    return if self.achievements.include?(achievement)

    if achievement
      user_achievements.create(achievement: achievement)
    end
  end

  def has_all_achievements_for(video)
    video.achievements_count == self.achievements.where(video_id: video.id).count
  end

  def complete_video(video)
    user_videos.find_by(video: video).update(is_complete: true)
  end

  def unlock_video(video)
    user_videos.find_or_create_by(video: video)
  end

  def available_plannings(type = nil)
    plannings = Planning.available.where("user_id = ? OR planning_type = ?", self.id, 'weekly')
    plannings = plannings.where(planning_type: type) if type.present?
    plannings = plannings.order(planning_type: :asc)
  end
end
