require 'rails_helper'

describe 'restaurants index page' do
  context 'with no restaurants' do
    it 'tells me there are no restaurants' do
      visit '/restaurants'
      expect(page).to have_content('No restaurants yet')
      expect(page).to have_link('Create a restaurant')
    end
  end

  context 'when there are restaurants' do
    before do
      Restaurant.create(name: 'Pret', address: '2 city road', cuisine: 'Thai')
    end
    
    it 'should show the restaurant(s)' do
      visit '/restaurants'
      expect(page).to have_content('Pret') 
    end
  end  
end

describe 'testing a javascript function' do
  before { Restaurant.create(name: 'KFC',
                             address: '1 High St, London',
                             cuisine: 'Thai') }

  it "changes restaurant titles to 'Hello World' when clicked", js: true do
    visit '/restaurants'
    click_button 'JS test button'

    expect(page).to have_content('Hello world')
  end
end