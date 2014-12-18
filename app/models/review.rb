class Review < ActiveRecord::Base
  belongs_to :restaurant

  validates :thoughts, presence: true, length: { minimum: 3 }
  validates :rating, presence: true
end
