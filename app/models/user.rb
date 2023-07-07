class User < ApplicationRecord
  include Hashid::Rails

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :reservations, dependent: :destroy
  has_many :shifts, through: :reservations

  has_many :user_logs, dependent: :destroy
  has_many :api_tokens, dependent: :destroy

  has_many :plannings, class_name: "Planning", dependent: :destroy

  after_create :create_permanent_planning

  def create_log(description)
    user_logs.create(description: description)
  end

  def create_permanent_planning
    planning = Planning.create_planning("permanent", self)
    planning.publish
  end
end
