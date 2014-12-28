require 'rails_helper'

describe 'creating a restaurant' do
  context 'when logged in' do
    before do
      user = User.create(email: 'tests@test.com', password: '12345678', password_confirmation: '12345678')
      login_as user
    end

    context 'with valid data' do
      it 'adds it to the restaurants index' do
        visit '/restaurants/new'
        fill_in 'Name', with: 'Nandos'
        fill_in 'Address', with: '10 City Road London'
        fill_in 'Cuisine', with: 'Thai food'      
        click_button 'Create Restaurant'

        expect(current_path).to eq('/restaurants')
        expect(page).to have_content('Nandos')
        expect(page).to have_link('Create a restaurant')
      end
    end

    context 'with invalid data' do
      it 'shows errors creating a new restaurant' do
        visit '/restaurants/new'
        fill_in 'Name', with: 'nandos'
        fill_in 'Address', with: '1'
        fill_in 'Cuisine', with: 'Thai'      
        click_button 'Create Restaurant'

        expect(current_path).to eq('/restaurants')
        expect(page).to have_content('errors')
      end
    end
  end

  context 'when logged out' do
    before { Restaurant.create(name: 'KFC', address: '1 High St, London',
                                 cuisine: 'Thai') }

    it "shows a 'Create a restaurant' link" do
      visit '/restaurants'

      expect(page).to have_link('Create a restaurant')
    end

    it 'takes us to the sign up page' do
      visit '/restaurants'
      click_link 'Create a restaurant'

      expect(page).to have_content('Sign up')
    end
  end
end