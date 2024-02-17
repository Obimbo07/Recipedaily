RSpec.feature 'Foods Show page', type: :feature do 
  let(:user_email) { 'trick@gmail.com' }
  let(:user_password) { 'f4k3p455w0rd' }
  
  before(:each) do
    user = User.find_or_create_by(email: user_email) do |u|
      u.password = user_password
      u.confirm
    end
    login_as(user, scope: :user)
    @food = Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: 20, user: user)
    visit food_path(@food)
  end
  
  scenario 'Users view individual food' do
    expect(page).to have_content('Rice')
    expect(page).to have_content('kg')
    expect(page).to have_content(10.00)
    expect(page).to have_content('20')
  end

  scenario 'Users can go back to foods index' do
    click_link 'Back to foods'
    expect(page).to have_current_path(foods_path)
  end

  scenario 'Users see three buttons' do
    expect(page).to have_link('Back to foods')
    expect(page).to have_link('Edit this food')
    expect(page).to have_link('Destroy this food')
  end
end
