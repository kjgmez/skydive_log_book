class Jump < ActiveRecord::Base
  belongs_to :user
  validates :altitude, numericality: {greater_than_or_equal_to: 2500, message: "should be more than 2500 without ','"}
  validates :jump_number, numericality: {greater_than: 0, message: "should be a number greater than 0"}
  validates :jump_number, :altitude, presence: true
end
