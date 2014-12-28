require 'rails_helper'

describe 'writing reviews' do
  before do 
      user1 = User.create(email: 'test1@test.com', password: '12345678',
                          password_confirmation: '12345678')
      user2 = User.create(email: 'test2@test.com', password: '12345678',
                          password_confirmation: '12345678')
      login_as user1
      user1.restaurants.create(name: 'Nandos', address: '2 city road',
                              cuisine: 'Thai') 
      logout
  end


  context 'logged out' do
    it 'does not show the review form' do
      visit '/restaurants'
      expect(page).not_to have_field('Thoughts')
    end
  end

  context 'logged in' do
    before do
      user3 = User.create(email: 'test3@test.com', password: '12345678',
                          password_confirmation: '12345678') 
      login_as user3
      restaurant3 = user3.restaurants.create(name: 'Restaurant3',
        address: '2 city road', cuisine: 'Thai')
    end

    it 'restaurants begin with no reviews' do
      visit '/restaurants'
      expect(page).to have_content('0 reviews')
    end
    
    it 'adds the review to the restaurant', js: true do
      leave_review(3, 'This was decent')

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('This was decent')
      expect(page).to have_content('1 review')
    end

    it 'calculates the average score of reviews', js: true do
      leave_review(4, 'This was decent')
      leave_review(2, 'Not bad')

      expect(page).to have_content('Average rating - 3')
    end

    before do
      logout
      user4 = User.create(email: 'test4@test.com', password: '12345678',
                          password_confirmation: '12345678')
      login_as user4
      restaurant4 = user4.restaurants.create(name: 'Restaurant3',
        address: '2 city road', cuisine: 'Thai')
    end
    
    it 'user can leave review for a restaurant that was not created by him', js: true do
      leave_review(2, 'not good')

      expect(page).to have_content('not good')
    end

    # it 'user can only leave one review per restaurant', js: true do
    #   leave_review(3, 'ok')

    #   expect(page).not_to have_content('ok')
    # end
  end
end

def leave_review(rating, thoughts)
  visit '/restaurants'
  fill_in 'Thoughts', with: thoughts, match: :first
  select rating.to_s, from: 'Rating', match: :first
  click_button 'Leave review', match: :first
end

# if the user wrote the review he can edit it? No users yet.
# only the most recent 5 reviews are shown. Do once factories set up.
# An average review score is shown.