require 'rails_helper'

describe 'writing reviews' do
  before { Restaurant.create(name: 'Nandos', address: '2 city road', cuisine: 'Thai') }

  it 'restaurants begin with no reviews' do
    visit '/restaurants'
    expect(page).to have_content('0 reviews')
  end
  
  it 'adds the review to the restaurant' do
    leave_review(3, 'This was decent')

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('This was decent')
    expect(page).to have_content('1 review')
  end

  it 'calculates the average score of reviews' do
    leave_review(4, 'This was decent')
    leave_review(2, 'Not bad')

    expect(page).to have_content('Average rating - 3')
  end

  def leave_review(rating, thoughts)
    visit '/restaurants'
    click_link 'Review Nandos'

    fill_in 'Thoughts', with: thoughts
    select rating.to_s, from: 'Rating'
    click_button 'Leave review' 
  end
end

# if the user wrote the review he can edit it? No users yet.
# only the most recent 5 reviews are shown. Do once factories set up.
# An average review score is shown.