require 'rails_helper'

describe 'deleting a restaurant' do
  context 'when logged in' do
    before do 
      user1 = User.create(email: 'test1@test.com', password: '12345678', password_confirmation: '12345678')
      user2 = User.create(email: 'test2@test.com', password: '12345678', password_confirmation: '12345678')
      login_as user1
      user2.restaurants.create(name: 'KFC', address: '1 High St, London',
                              cuisine: 'Thai') 
    end
    
    it 'only removes a restaurant if it belongs to the user' do
      visit '/restaurants'
      click_link 'Delete KFC'

      expect(page).to have_content('KFC')
      expect(page).not_to have_content('Deleted successfully') 
    end
  end

  context 'when logged out' do
    it 'shows no delete link' do
      visit '/restaurants'

      expect(page).not_to have_link('Delete KFC')
    end
  end
end