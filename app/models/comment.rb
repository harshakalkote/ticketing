class Comment < ActiveRecord::Base
  belongs_to :ticket

  validates :description, presence: true
end
