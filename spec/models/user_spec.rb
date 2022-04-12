require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'generates user first and last name, unique email, password and password confirmation' do
      @user = User.new(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
      @user.save

      expect(@user).to be_valid
    end

    
  end
  
end
