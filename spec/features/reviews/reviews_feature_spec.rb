require 'rails_helper'

def leave_review(rating, thoughts)
  visit '/restaurants'
  fill_in 'Thoughts', with: thoughts
  select rating.to_s, from: 'Rating'
  click_button 'Leave review'
end

describe 'writing reviews' do
  before do 
      @user1 = User.create(email: 'test1@test.com', password: '12345678',
                          password_confirmation: '12345678')
      @user2 = User.create(email: 'test2@test.com', password: '12345678',
                          password_confirmation: '12345678')
      # @user1.restaurants.create(name: 'Nandos', address: '2 city road',
      #                         cuisine: 'Thai')
      @user2.restaurants.create(name: 'Nando2', address: '2 city road',
                              cuisine: 'Thai') 
  end

  context 'when logged out' do # Working
    it 'does not show the review form' do
      visit '/restaurants'
      expect(page).not_to have_field('Thoughts')
    end
  end

  context 'when logged in' do
    before do
      login_as @user1
    end

    it 'restaurants begin with no reviews' do
      visit '/restaurants'
      expect(page).to have_content('0 reviews')
    end
    
    it 'a user can add a review to a restaurant which he did not create', js: true do
      leave_review(3, 'This was decent')

      expect(current_path).to eq '/restaurants'
      expect(page).not_to have_content('This was decent')
      expect(page).to have_content('1 review')
    end
    
    it 'will calculate the average score of reviews' do
      leave_review(4, 'This was decent')
      logout
      login_as @user2
      leave_review(2, 'Not bad')

      expect(page).to have_content('Average rating - 3')
    end
    
    it 'a user can only leave one review per restaurant' do
      leave_review(3, 'Okay')
      leave_review(5, 'Great')

      expect(page).to have_content('Okay')
      expect(page).not_to have_content('Great')
      expect(page).to have_content('You already reviewed this restaurant!')
    end
  end
end

# a non logged in user cannot leave a review. (y/n?)
# if the user wrote the review he can edit it? No users yet.
# only the most recent 5 reviews are shown. Do once factories set up.
# An average review score is shown.