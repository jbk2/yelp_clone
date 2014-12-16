require 'rails_helper'

describe 'restaurants listing page' do
  
  context 'with no restaurants' do
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

  context 'when there are restaurants' do
    before do
      Restaurant.create(name: 'Pret', address: '2 city road', cuisine: 'Thai')
    end
    
    it 'should show the restaurant' do
      visit '/restaurants'
      expect(page).to have_content('Pret') 
    end
    
    describe 'editing a restaurant' do
      before { Restaurant.create(name: 'KFC', address: '1 High St, London',
                                 cuisine: 'Thai') }

      it 'saves the change to the restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'

        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'

        expect(current_path).to eq '/restaurants'
        expect(page).to have_content('Kentucky Fried Chicken')
      end
    end

    describe 'deleting a restaurant' do
      before { Restaurant.create(name: 'KFC', address: '1 High St, London',
                                cuisine: 'Thai') }

      it 'removes a restaurant from the listing' do
        visit '/restaurants'
        click_link 'Delete KFC'

        expect(page).not_to have_content('KFC')
        expect(page).to have_content('Deleted successfully') 

      end
    end

  end
end