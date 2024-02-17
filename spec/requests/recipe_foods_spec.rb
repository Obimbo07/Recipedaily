# spec/requests/recipe_foods_controller_spec.rb
require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :request do
  let(:user) do
    User.find_or_create_by(email: 'pami@recipedaily.com') do |u|
      u.password = 'password'
      u.password_confirmation = 'password'
      u.confirm
    end
  end
  let(:recipe) do
    Recipe.create(user:, name: 'test', description: 'test description', cooking_time: 1, preparation_time: 1)
  end
  let(:food) { Food.create(user:, name: 'Example Food', quantity: 500, measurement_unit: 'gm', price: 1) }
  let(:recipe_food) { RecipeFood.create(quantity: 1, food:, recipe:) }

  include Devise::Test::IntegrationHelpers
  before(:each) do
    sign_in user
    Food.create(user:, name: 'test', quantity: 500, measurement_unit: 'gm', price: 1)
    RecipeFood.create(quantity: 1, food:, recipe:)
  end

  describe 'GET /recipes/:recipe_id/recipe_foods/new' do
    it 'renders the new template' do
      get new_recipe_recipe_food_path(recipe)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /recipes/:recipe_id/recipe_foods/:id/edit' do
    it 'renders the edit template' do
      get edit_recipe_recipe_food_path(recipe, recipe_food)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /recipes/:recipe_id/recipe_foods' do
    it 'creates a new recipe_food' do
      post recipe_recipe_foods_path(recipe),
           params: { recipe_food: { food_name: 'test', quantity: 5, recipe_id: recipe.id } }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq(I18n.t('recipe_food.create.success'))
    end

    it "fails to create if food doesn't exist" do
      post recipe_recipe_foods_path(recipe.id),
           params: { recipe_food: { food_name: 'Non-Existent Food', quantity: 5, recipe_id: recipe.id } }
      expect(response).to redirect_to(new_recipe_recipe_food_path(recipe))
      expect(flash[:alert]).to eq(I18n.t('recipe_food.create.failure'))
    end
  end

  describe 'PATCH /recipes/:recipe_id/recipe_foods/:id' do
    it 'updates the recipe_food' do
      patch recipe_recipe_food_path(recipe, recipe_food), params: { recipe_food: { quantity: 10 } }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq(I18n.t('recipe_food.update.success'))
    end
  end

  describe 'DELETE /recipes/:recipe_id/recipe_foods/:id' do
    it 'destroys the recipe_food' do
      delete recipe_recipe_food_path(recipe, recipe_food)
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq(I18n.t('recipe_food.destroy.success'))
    end
  end
end
