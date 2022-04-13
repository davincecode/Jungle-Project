require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do

  before(:each) do
    @user = User.create!(first_name: 'Ruby', last_name: 'Rails', email: 'sample@example.com', password: '123456', password_confirmation: '123456')
  end

  scenario "Can login with correct credentials" do
    visit login_path

    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'

    within('form') do
      fill_in 'email', with: 'sample@example.com'
      fill_in 'password', with: '123456'
      click_button('Submit')
    end

    expect(page).to have_content 'Signed in as sample@example.com'

  end

end
