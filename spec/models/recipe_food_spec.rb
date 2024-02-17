require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before :all do
    @recipe = Recipe.new(user: @user, name: 'Pasta', description: 'Pasta with tomato sauce', cooking_time: 1,
                         preparation_time: 1)
    @food = Food.new(name: 'Tomato', measurement_unit: 'kg', price: 15, quantity: 3)
  end

  it 'is valid with valid attributes' do
    recipe_food = RecipeFood.new(recipe: @recipe, food: @food, quantity: 1)
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a recipe' do
    recipe_food = RecipeFood.new(food: @food, quantity: 1)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without a food' do
    recipe_food = RecipeFood.new(recipe: @recipe, quantity: 1)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without a quantity' do
    recipe_food = RecipeFood.new(recipe: @recipe, food: @food)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without a user' do
    recipe_food = RecipeFood.new(quantity: 1)
    expect(recipe_food).not_to be_valid
  end
end
