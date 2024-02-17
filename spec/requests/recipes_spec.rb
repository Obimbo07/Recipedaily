require 'rails_helper'

RSpec.describe '/recipes', type: :request do
  let(:user) { User.create(email: 'abc@example.com', password: 'password', confirmed_at: Time.now) } # Confirm the user

  let(:valid_attributes) do
    {
      name: 'test',
      description: 'Testing',
      cooking_time: 1,
      preparation_time: 2,
      user_id: user.id # Assign the user id
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      description: 'Testing',
      cooking_time: 1,
      preparation_time: 2,
      user_id: user.id # Assign the user id
    }
  end

  before(:each) do
    login_as(user, scope: :user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Recipe.create! valid_attributes
      get recipes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /' do
    it 'should get public recipes' do
      get '/'
      expect(response).to be_successful # Use RSpec's expect method
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      recipe = Recipe.create! valid_attributes
      get recipe_url(recipe)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'should update recipe as public' do
      recipe = Recipe.create! valid_attributes
      put toggle_public_recipe_url(recipe.id), params: { recipe: { public: true } }, as: :json
      expect(response).to be_successful # Use RSpec's expect method
      recipe.reload
      expect(recipe.public).to be_truthy # Use RSpec's expect method
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_recipe_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Recipe' do
        expect do
          post recipes_url, params: { recipe: valid_attributes }
        end.to change(Recipe, :count).by(1) # Use RSpec's change matcher
      end

      it 'redirects to the created recipe' do
        post recipes_url, params: { recipe: valid_attributes }
        expect(response).to redirect_to(recipe_url(Recipe.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Recipe' do
        expect do
          post recipes_url, params: { recipe: invalid_attributes }
        end.to change(Recipe, :count).by(0) # Use RSpec's change matcher
      end

      it "renders a response with 4222 status (i.e. to display the 'new' template)" do
        post recipes_url, params: { recipe: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested recipe' do
      recipe = Recipe.create! valid_attributes
      expect do
        delete recipe_url(recipe)
      end.to change(Recipe, :count).by(-1) # Use RSpec's change matcher
    end

    it 'redirects to the recipes list' do
      recipe = Recipe.create! valid_attributes
      delete recipe_url(recipe)
      expect(response).to redirect_to(recipes_url)
    end
  end
end
