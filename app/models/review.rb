class Review < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :user_id, uniqueness: true
  validates :stars, presence: true, inclusion: { in: 1..10 }
  validates :comment, presence: true, length: { minimum: 3 }
end
