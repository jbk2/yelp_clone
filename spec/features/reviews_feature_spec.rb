require 'rails_helper'

describe 'writing reviews' do
  before { Restaurant.create(name: 'Nandos', address: '2 city road', cuisine: 'Thai') }

  it 'restaurants begin with no reviews' do
    visit '/restaurants'
    expect(page).to have_content('0 Reviews')
  end
  
  it 'adds the review to the restaurant' do
    visit '/restaurants'
    click_link 'Review Nandos'

    fill_in 'Thoughts', with: 'This was decent'
    select '4', from: 'Rating'
    click_button 'Leave review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('This was decent')
    expect(page).to have_content('1 Review')
  end
end