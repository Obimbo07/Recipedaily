require 'rails_helper'

RSpec.describe '/general_shopping_list', type: :request do
  let(:user) do
    User.create!(
      email: 'testing@recipedaily.com',
      password: 'f4k3p455w0rd',
      confirmed_at: Time.now
    )
  end

  before(:each) do
    login_as(user, scope: :user)
    Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: 20, user:)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get general_shopping_list_url
      expect(response).to be_successful
    end
  end
end
