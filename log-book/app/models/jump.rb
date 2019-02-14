class Jump < ActiveRecord::Base
  belongs_to :user
  validates :jump_number, :altitude, presence: true
end
