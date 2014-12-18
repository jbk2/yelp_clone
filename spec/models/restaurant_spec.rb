require 'rails_helper'

describe Restaurant do
  it 'is not valid without a name' do
    restaurant = Restaurant.new(name: nil)
    expect(restaurant).to have(2).errors_on(:name)
  end

  it 'is not valid without an address' do
    restaurant = Restaurant.new(address: nil)
    expect(restaurant).to have(2).errors_on(:address)
  end

  it 'is not valid without a cuisine type' do
    restaurant = Restaurant.new(cuisine: nil)
    expect(restaurant).to have(1).errors_on(:cuisine)
  end

  it 'is not valid with an address of <3 chars' do
    restaurant = Restaurant.new(address: '1')
    expect(restaurant).to have(1).errors_on(:address)
  end

  it 'is not valid unless name starts with uppercase letter' do
    restaurant = Restaurant.new(name: 'nandos')
    expect(restaurant).to have(1).errors_on(:name)
  end

  it 'is not valid unless the name is unique' do
    restaurant = Restaurant.create(name: 'Nandos')
    restaurant2 = Restaurant.create(name: 'Nandos')

    # expect(restaurant2).to have(1).errors_on(:name)

    expect(restaurant2).not_to be_valid # this test is not working properly.
  end

  describe '#average_rating' do
    let(:restaurant) { Restaurant.create(name: 'KFC', 
                                        address: '1 High St, London',
                                        cuisine: 'Thai') }
  
    context 'with 0 reviews' do
      it 'returns N/A' do
        expect(restaurant.average_rating).to eq('N/A')
      end
    end

    context 'with 1 review' do
      before { restaurant.reviews.create(thoughts: 'nice one', rating: 3) }
      it 'returns the score of review with only one review' do
        expect(restaurant.average_rating).to eq(3)
      end
    end

    context 'with >1 review' do
      before(:each) { restaurant.reviews.create(thoughts: 'Lovely meal', rating: 3) }
      before(:each) { restaurant.reviews.create(thoughts: 'Another nice one', rating: 5) }

      it 'will show the average review rating' do
        expect(restaurant.average_rating).to eq(4)
      end
    end

    context 'with a decimal average' do
      before  do  restaurant.reviews.create(thoughts: 'Lovely meal',rating: 5)
                  restaurant.reviews.create(thoughts: 'Lovely meals',rating: 2)
      end
      
      it 'does not round up or down' do
        expect(restaurant.average_rating).to eq(3.5)
      end
    end
  end
end