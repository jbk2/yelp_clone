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

  describe 'creating a restaurant' do
    # context 'when logged in' do
    #   context 'with valid data' do
    #     it 'adds it to the restaurants index' do
    #       visit '/restaurants/new'
    #       fill_in 'Name', with: 'Nandos'
    #       fill_in 'Address', with: '10 City Road London'
    #       fill_in 'Cuisine', with: 'Thai food'      
    #       click_button 'Create Restaurant'

    #       expect(current_path).to eq('/restaurants')
    #       expect(page).to have_content('Nandos')
    #       expect(page).to have_link('Create a restaurant')
    #     end
    #   end

    #   context 'with invalid data' do
    #     it 'shows errors creating a new restaurant' do
    #       visit '/restaurants/new'
    #       fill_in 'Name', with: 'nandos'
    #       fill_in 'Address', with: '1'
    #       fill_in 'Cuisine', with: 'Thai'      
    #       click_button 'Create Restaurant'

    #       expect(current_path).to eq('/restaurants')
    #       expect(page).to have_content('errors')
    #     end
    #   end
    # end

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


  describe 'editing a restaurant' do
    before { Restaurant.create(name: 'KFC', address: '1 High St, London',
                              cuisine: 'Thai') }

    # context 'when logged in' do
    #   context 'with valid data' do
        

    #     it 'saves the change to the restaurant and shows it' do
    #       visit '/restaurants'
    #       click_link 'Edit KFC'

    #       fill_in 'Name', with: 'Kentucky Fried Chicken'
    #       click_button 'Update Restaurant'

    #       expect(current_path).to eq '/restaurants'
    #       expect(page).to have_content('Kentucky Fried Chicken')
    #     end
    #   end
    
    #   context 'with invalid data' do
    #     it 'shows errors editing with invalid name' do
    #       visit '/restaurants/new'
    #       fill_in 'Name', with: 'Nandos'
    #       fill_in 'Address', with: '10 City Road London'
    #       fill_in 'Cuisine', with: 'Thai food'      
    #       click_button 'Create Restaurant'
    #       click_link 'Edit Nandos'
    #       fill_in 'Name', with: 'nandos'
    #       click_button 'Update Restaurant'

    #       expect(page).to have_content('error')
    #     end
    #   end
    # end

    context 'when logged out' do
      it 'shows no edit link' do
        visit '/restaurants'

        expect(page).not_to have_link('Edit KFC')
      end
    end
  end
        
  describe 'deleting a restaurant' do
    before { Restaurant.create(name: 'KFC', address: '1 High St, London',
                                   cuisine: 'Thai') }
    # context ' when logged in' do
    #   it 'removes a restaurant from the listing' do
    #     visit '/restaurants'
    #     click_link 'Delete KFC'

    #     expect(page).not_to have_content('KFC')
    #     expect(page).to have_content('Deleted successfully') 
    #   end
    # end

    context 'when logged out' do
      it 'shows no delete link' do
        visit '/restaurants'

        expect(page).not_to have_link('Delete KFC')
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
end