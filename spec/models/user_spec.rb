require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    context "All fields properly filled out" do
      it "Creates the user successfully" do
        user = User.new
        user.first_name = "Michael"
        user.last_name = "Jordan"
        user.email = "mjhoops@gmail.com"
        user.password = "u2hd874353kj23hr"
        user.password_confirmation = "u2hd874353kj23hr"
        user.save
        expect(user.errors.full_messages).to match_array([])
      end
    end

  end
end
