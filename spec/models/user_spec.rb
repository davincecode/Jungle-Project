require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'generates user first and last name, unique email, password and password confirmation' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user).to be_valid
    end

    it 'shows an error if first name is empty' do
      @user = User.new(first_name: nil, last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be empty")
    end

    it 'shows an error if last name is empty' do
      @user = User.new(first_name: 'Ruby', last_name: nil, email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be empty")
    end

    it 'shows an error if email is empty' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: nil, password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be empty")
    end

    it 'shows an error if email is not unique' do
      @user1 = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user1.save

      @user2 = User.new(first_name: 'Rubyx', last_name: 'Raily', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user2.save

      expect(@user1).to be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'shows an error password does not match' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456Y')
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'shows an error if password is empty' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: nil, password_confirmation: nil)
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be empty")
    end

    it 'shows an error if password is short' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '12', password_confirmation: '12')
      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
    
  end

  describe '.authenticate_with_credentials' do
    
    it 'should allow login with correct credentials' do
      @user = User.create!(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')

      @login = User.authenticate_with_credentials('sample@example.com', '123456')
      
      expect(@user).to eq(@login)

    end

    it 'should not allow login with correct credentials' do
      @user = User.create!(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')

      @login = User.authenticate_with_credentials('sample@example.com', '1234564')
      
      expect(@login).to eq(nil)

    end

    it 'should allow login if email has whitespace' do
      @user = User.create!(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')

      @login = User.authenticate_with_credentials('   sample@example.com  ', '123456')
      
      expect(@user).to eq(@login)

    end

    it 'should allow login if email has case error' do
      @user = User.create!(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')

      @login = User.authenticate_with_credentials('sample@example.com', '123456')
      
      expect(@user).to eq(@login)

    end

    
  end
  
end
