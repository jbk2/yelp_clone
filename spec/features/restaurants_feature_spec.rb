require 'rails_helper'

describe 'restaurants listing page' do
  
  context 'no restaurants' do
    it 'tells me there are no restaurants' do
      visit '/restaurants'
      expect(page).to have_content('No restaurants yet')
    end
  end

  context 'creating a restaurant' do
    it 'adds to the restaurants index' do
      visit '/restaurants/new'
      fill_in 'Name', with: 'Nandos'
      fill_in 'Address', with: '10 City Road, London'
      click_button 'Create Restaurant'

      expect(current_path).to eq('/restaurants')
      expect(page).to have_content('Nandos')
    end
  end

  context 'are restaurants' do
    before do
      Restaurant.create(name: 'Pret')
    end
    
    it 'should show the restaurant' do
      visit '/restaurants'
      expect(page).to have_content('Pret')
    end
  end

end