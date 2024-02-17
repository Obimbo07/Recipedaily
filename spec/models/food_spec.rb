require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create!(email: 'model@recipedaily.com', password: 'password123') }

  before do
    Devise::Mailer.default_url_options[:host] = 'recipedaily.com'
    @food = Food.create(
      name: 'Tomato',
      measurement_unit: 'kg',
      price: 15,
      quantity: 3,
      user: # Assign the user to the food
    )
  end

  it 'is valid with valid attributes' do
    expect(@food).to be_valid
  end

  it 'is not valid without a name' do
    @food.name = nil
    expect(@food).not_to be_valid
  end

  it 'is not valid without a measurement unit' do
    @food.measurement_unit = nil
    expect(@food).not_to be_valid
  end

  it 'is not valid without a price' do
    @food.price = nil
    expect(@food).not_to be_valid
  end

  it 'is not valid without a quantity' do
    @food.quantity = nil
    expect(@food).not_to be_valid
  end

  it 'is not valid without a user' do
    @food.user = nil
    expect(@food).not_to be_valid
  end
end
