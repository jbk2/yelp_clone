class Restaurant < ActiveRecord::Base
  validates :name, presence: true,
  format: { with: /\A[A-Z]/, message: 'must begin capitalized' },
  uniqueness: true
  validates :address, presence: true, length: { minimum: 3 }
  validates :cuisine, presence: true
  has_many :reviews
end
