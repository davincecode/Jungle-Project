require 'rails_helper'

RSpec.feature "Users can navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create!(name: 'Apparel')
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
  end

  scenario 'users can see the product details page' do
    visit root_path
    find_link("Details").trigger("click")

    # save_screenshot
    # sleep 1
    # puts page.html

    expect(page).to have_css 'section.products-show'
  end

end