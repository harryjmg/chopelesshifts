class User < ApplicationRecord
  include Hashid::Rails

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :reservations
  has_many :shifts, through: :reservations

  has_many :user_logs

  def create_log(description)
    user_logs.create(description: description)
  end
end
