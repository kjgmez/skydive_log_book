class User < ActiveRecord::Base
  has_secure_password
  has_many :jumps
  validates :username, uniqueness: true
  validates :username, :password_digest, presence: true
end
