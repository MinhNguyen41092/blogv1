class User < ActiveRecord::Base
  has_many :articles
  has_many :likes
  has_many :comments
  validates :username, presence: true, length: { minimum: 3, maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
    uniqueness: {case_sensitive: false },
    format: { with: VALID_EMAIL_REGEX }
  before_save { self.email.downcase! if email }
  has_secure_password
end
