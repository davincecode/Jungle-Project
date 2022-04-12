require 'rails_helper'

# Each example (it) is run in isolation of others. Therefore each example will needs its own @category created and then @product initialized with that category
# Create an initial example that ensures that a product with all four fields set will indeed save successfully
# Have one example for each validation, and for each of these:
# Set all fields to a value but the validation field being tested to nil
# Test that the expect error is found within the .errors.full_messages array
# You should therefore have five examples defined given that you have the four validations above

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    
      it 'validates all fields are present' do
        product = Product.new
        product.name = 'Test Product'
        product.price = 10.00
        product.quantity = 10
        product.category = Category.new
        expect(product).to be_valid
      end

      it 'validates :name, presence: true' do
        product = Product.new(name: nil)
        category = Category.new
        product.category = category
        expect(product).to_not be_valid
      end

      it 'validates :price, presence: true' do
        product = Product.new(price: nil)
        category = Category.new
        product.category = category
        expect(product).to_not be_valid
      end

      it 'validates :quantity, presence: true' do
        product = Product.new(quantity: nil)
        category = Category.new
        product.category = category
        expect(product).to_not be_valid
      end

      it 'validates :category, presence: true' do
        product = Product.new(category: nil)
        expect(product).to_not be_valid
      end

  end
end
