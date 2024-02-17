require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :all do
    @user = User.new(email: 'micronaut@recipedaily.com', password: 'password@2024')
  end

  it 'is valid with valid attributes' do
    recipe = Recipe.new(user: @user, name: 'Pasta', description: 'Pasta with tomato sauce', cooking_time: 1,
                        preparation_time: 1)
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    recipe = Recipe.new(user: @user, description: 'Pasta with tomato sauce', cooking_time: 1, preparation_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without a description' do
    recipe = Recipe.new(user: @user, name: 'Pasta', cooking_time: 1, preparation_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without a cooking time' do
    recipe = Recipe.new(user: @user, name: 'Pasta', description: 'Pasta with tomato sauce', preparation_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without a preparation time' do
    recipe = Recipe.new(user: @user, name: 'Pasta', description: 'Pasta with tomato sauce', cooking_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without a user' do
    recipe = Recipe.new(name: 'Pasta', description: 'Pasta with tomato sauce', cooking_time: 1, preparation_time: 1)
    expect(recipe).not_to be_valid
  end
end
