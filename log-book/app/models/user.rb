class User < ActiveRecord::Base
  has_secure_password
  has_many :jumps

  validates :username, uniqueness: true
  #validates :password, length: {minimum: 5}
  validates :username, :password_digest, presence: true
  validates :name, :license, :canopy_size, presence: true, if: :saved?
  validates :license, length: {maximum: 1, message: "should only be 1 letter"}
  validates :license, inclusion: {in: ("A".."D"), message: "should be between A-D and capitalized", allow_nil: true}
  validates :canopy_size, numericality: { only_integer: true, allow_nil: true}

  def saved?
    self.id != nil
  end
end
