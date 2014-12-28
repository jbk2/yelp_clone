require 'rails_helper'

describe 'editing a restaurant' do
  context 'when logged in' do
    before do 
      user = User.create(email: 'tests@test.com', password: '12345678', password_confirmation: '12345678')
      login_as user
      user.restaurants.create(name: 'KFC', address: '1 High St, London',
                              cuisine: 'Thai') 
    end

    context 'with valid data' do    

      it 'saves the change to the restaurant and shows it' do
        visit '/restaurants'
        click_link 'Edit KFC'

        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'

        expect(current_path).to eq '/restaurants'
        expect(page).to have_content('Kentucky Fried Chicken')
      end
    end
  
    context 'with invalid data' do
      it 'shows errors editing with invalid name' do
        visit '/restaurants/new'
        fill_in 'Name', with: 'Nandos'
        fill_in 'Address', with: '10 City Road London'
        fill_in 'Cuisine', with: 'Thai food'      
        click_button 'Create Restaurant'
        click_link 'Edit Nandos'
        fill_in 'Name', with: 'nandos'
        click_button 'Update Restaurant'

        expect(page).to have_content('error')
      end
    end
  end

  context 'when logged out' do
    it 'shows no edit link' do
      visit '/restaurants'

      expect(page).not_to have_link('Edit KFC')
    end
  end
end    