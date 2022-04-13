require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'generates user first and last name, unique email, password and password confirmation' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user).to eq(@user)
    end

    it 'shows an error if first name is empty' do
      @user = User.new(first_name: nil, last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user.errors.full_messages).to eq(["First name can't be blank"])
    end
    
    it 'shows an error if last name is empty' do
      @user = User.new(first_name: 'Ruby', last_name: nil, email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    it 'shows an error if email is empty' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: nil, password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it 'shows an error if email already exist' do
      @user1 = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user1.save

      @user2 = User.new(first_name: 'Rubyx', last_name: 'Raily', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user2.save

      expect(@user1).to be_valid
      expect(@user2.errors.full_messages).to eq(["Email has already been taken"])
    end

    it "shows an error if password is empty" do
      user = User.new(first_name: "Ruby", last_name: "Rails", email: "sample@example.com")
      user.valid?

      expect(user.errors[:password]).to include("can\'t be blank")
    end

    it "shows an error if password confirmation doesn't match password" do
      user = User.new(first_name: "Ruby", last_name: "Rails", email: "sample@example.com", password: "123456", password_confirmation: "1234567")
      user.valid?

      expect(user.errors[:password_confirmation]).to include("doesn\'t match Password")
    end


  end

#Authentication test

  describe '.authenticated_credentials' do
      
      it 'validates login credentials' do
        user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
        user.save

        authenticated_user = User.authenticated_credentials('sample@example.com', '123456')

        expect(authenticated_user).to eq(user)
      end

      it 'returns nil if user is not found' do
        user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
        user.save

        authenticated_user = User.authenticated_credentials('sample@example.com', '1234567')

        expect(authenticated_user).to eq(nil)
      end

      it 'returns nil if password is incorrect' do
        user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')

        authenticated_user = User.authenticated_credentials('sample@example.com', '1234567')

        expect(authenticated_user).to eq(nil)
      end

      it 'returns nil if email is incorrect' do
        user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')

        authenticated_user = User.authenticated_credentials('sampler@example.com', '123456')

        expect(authenticated_user).to eq(nil)
      end

    end
end
