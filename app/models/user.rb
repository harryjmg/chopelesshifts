class User < ApplicationRecord
  include Hashid::Rails

  authenticates_with_sorcery!

  validates :first_name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :reservations, dependent: :destroy
  has_many :shifts, through: :reservations

  has_many :user_logs, dependent: :destroy
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

  def create_log(description)
    user_logs.create(description: description)
  end

  def create_permanent_planning
    planning = Planning.create_planning("permanent", self)
    planning.publish
  end

  def create_daily_planning
    planning = Planning.create_planning("daily", self)
    planning.publish
  end

  def record_achievement(key)
    achievement = Achievement.find_by(key: key)
    return if self.achievements.include?(achievement)
    user_achievements.create(achievement: achievement) if achievement
    user_videos.create(video: Video.find_by(unlocked_by: key)) if achievement
  end
end
