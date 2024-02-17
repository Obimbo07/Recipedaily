RSpec.feature 'Foods Index Page', type: :feature do
  let(:user_email) { 'testing2@gmail.com' }
  let(:user_password) { 'f4k3p455w0rd' }

  before(:each) do
    user = User.find_or_create_by(email: user_email) do |u|
      u.password = user_password
      u.confirm
    end
    login_as(user, scope: :user)
    Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: 20, user:)
    Food.create(name: 'Chicken', measurement_unit: 'kg', price: 30, quantity: 10, user:)
    Food.create(name: 'Beef', measurement_unit: 'kg', price: 50, quantity: 10, user:)
    visit foods_path
  end

  scenario 'User views their Food list on index' do
    expect(page).to have_content('Rice')
    expect(page).to have_content('Chicken')
  end

  scenario 'User views delete Food button on index' do
    foods = Food.where(user: User.find_by(email: user_email))
    foods.each do |_food|
      expect(page).to have_content('Remove')
    end
  end

  scenario 'User clicks on a New Food and is redirected to their New Food page' do
    click_link 'New food'
    expect(page).to have_current_path(new_food_path)
  end
end
