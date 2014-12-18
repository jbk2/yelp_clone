class Restaurant < ActiveRecord::Base

  validates :name, presence: true,
  format: { with: /\A[A-Z]/, message: 'must begin capitalized' },
  uniqueness: true
  validates :address, presence: true, length: { minimum: 3 }
  validates :cuisine, presence: true
  has_many :reviews # This is the same as writing #reviews method below.

  # def reviews
  #   Review.where(restaurant_id: self.id)
  # end
  
  def average_rating
    if reviews.any?
      reviews.inject(0) { |total, review|
        total + review.rating
      } / reviews.count.to_f
    else
      'N/A'
    end
  end

end

  # def average_rating
  #   if reviews.any?
  #     counter = 0
  #     reviews.inject(0) do |total, review|
  #       counter +=1
  #       total + review.rating / counter
  #     end
  #   else
  #     'N/A'
  #   end
  # end
