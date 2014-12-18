require 'rails_helper'

describe Review do
  it 'is not valid with an empty Thoughts field' do
    review = Review.new(thoughts: nil)
    expect(review).to have(2).errors_on(:thoughts)
  end

  it 'is not valid without a rating' do
    review = Review.new(rating: nil)
    expect(review).to have(1).errors_on(:rating)
  end

  it 'is not valid with a thoughts entry of <3 chars' do
    review = Review.new(thoughts: 'He')
    expect(review).to have(1).errors_on(:thoughts)
  end

end
