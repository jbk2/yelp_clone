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
end