class User < ApplicationRecord
  include Hashid::Rails

  authenticates_with_sorcery! do |config|
    config.submodules = [:remember_me, :activation, :reset_password]
  end

  before_validation :downcase_email

  validates :first_name, presence: true, on: :create
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, on: :create

  validates :email, uniqueness: true, presence: true
  validate :email_format

  has_many :reservations, dependent: :destroy
  has_many :shifts, through: :reservations

  has_many :api_tokens, dependent: :destroy
  has_many :api_requests, dependent: :destroy
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  has_many :plannings, class_name: "Planning", dependent: :destroy

  has_many :reviews, dependent: :destroy

  after_create :create_permanent_planning
  after_create :create_daily_planning

  MAX_API_REQUESTS_PER_10_MINUTE = 500

  def api_requests_within_last_10_minutes
    api_requests.where("created_at > ?", 10.minutes.ago).count
  end

  def api_requests_within_last_10_seconds
    api_requests.where("created_at > ?", 10.seconds.ago).count
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
    return false if !has_all_achievements_for(video)

    user_videos.find_by(video: video).update(is_complete: true)
    user_videos.find_or_create_by(video: video.next_video) 
    update_level
    track_action("Shift Heroes - Complete video", { video: video.title, level: current_level })
  end

  def update_level
    videos_completed_count = self.user_videos.where(is_complete: true).count
    self.update(current_level: videos_completed_count)
  end

  def available_plannings(type = nil)
    plannings = Planning.available.where("user_id = ? OR planning_type = ?", self.id, 'weekly')
    plannings = plannings.where(planning_type: type) if type.present?
    plannings = plannings.order(planning_type: :asc)
  end

  def has_review?
    reviews.exists?
  end

  def can_review?
    current_level >= 6 && !has_review?
  end

  def last_video_accessible
    user_videos.sort_by { |uv| Video::CUSTOM_IDS_IN_ORDER.index(uv.video.custom_id) }.last&.video || Video.find_by(custom_id: "environment_and_api")
  end

  def track_action(event, properties = {})
    properties.merge!({ email: self.email })
    MixpanelTrackUserJob.perform_later(event, properties)
  end

  def add_to_mailing_list
    AddUserToMailingListJob.perform_later(self)
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def email_format
    unless email =~ URI::MailTo::EMAIL_REGEXP
      errors.add(:email, "n'est pas valide")
    end
  end
end
