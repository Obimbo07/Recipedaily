require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(email: 'pam@recipedaily.com', password: 'password123')
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(password: 'password123')
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user = User.new(email: 'pam@recipedaily')
    expect(user).not_to be_valid
  end

  it 'is not valid without an email and password' do
    user = User.new
    expect(user).not_to be_valid
  end

  it 'is not valid with a password less than 6 characters' do
    user = User.new(email: 'pam@recipedaily', password: 'pass')
    expect(user).not_to be_valid
  end

  it 'authenticates a user with a valid password' do
    user = User.create(email: 'pam@recipedaily.com', password: 'password123')
    expect(user.valid_password?('password123')).to be true
  end

  it 'does not authenticate a user with an invalid password' do
    user = User.create(email: 'pam@recipedaily', password: 'password123')
    expect(user.valid_password?('password')).to be false
  end
end
