require 'rails_helper'

RSpec.describe '/foods', type: :request do
  let(:valid_attributes) do
    { name: 'Test Food', measurement_unit: 'kg', quantity: 10, price: 5.0 }
  end

  let(:valid_user_attributes) do
    { name: 'Test User', email: 'user@example.com', password: 'password', password_confirmation: 'password' }
  end

  let(:user) do
    user = User.create! valid_user_attributes
    # Confirm the user's email if necessary
    user.confirm if user.respond_to?(:confirm)
    sign_in user
    user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Food.create! valid_attributes.merge(user:)
      get foods_url
      expect(response).to be_successful
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested food' do
      food = Food.create! valid_attributes.merge(user:)
      expect do
        delete food_url(food)
      end.to change(Food, :count).by(-1)
    end
  end
end
