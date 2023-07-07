class ApiToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true, uniqueness: true
  before_validation :generate_token, on: :create

  validate do |api_token|
    api_token.errors.add(:base, "Too many tokens") if user.api_tokens.count >= 50
  end

  private 

  def generate_token
    self.token = Digest::MD5.hexdigest("#{Time.now.to_i}#{rand(1000)}")
  end

end
