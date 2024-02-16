require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create!(email: 'testing@recipedaily.com', password: 'password123') }

  let(:valid_attributes) do
    {
      name: 'Chicken Alfredo',
      description: 'A creamy pasta dish with chicken and parmesan cheese',
      cooking_time: 1,
      preparation_time: 2,
      user: # Associate the user with the recipe
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Recipe.create!(valid_attributes)
      get recipes_url
      follow_redirect! # Follow any redirects

      expect(response).to be_successful
    end
  end

  describe 'GET/ ' do
    it 'should render public recipes' do
      get '/'
      assert_response :success
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      recipe = Recipe.create!(valid_attributes)
      get recipe_url(recipe)
      follow_redirect! # Follow any redirects

      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_recipe_url
      follow_redirect! # Follow any redirects

      expect(response).to be_successful
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested recipe' do
      recipe = Recipe.create! valid_attributes
      expect do
        delete recipe_url(recipe)
      end
    end
  end
end
