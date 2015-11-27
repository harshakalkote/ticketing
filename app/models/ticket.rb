class Ticket < ActiveRecord::Base

  STATUS_TYPES = {1 => "NEW", 2 => "OPEN", 3 => "CLOSED"}

  has_many :comments
  validates :title, presence: true
  validates :customer_email, presence: true

end
