class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD']

  def show
    @categories = Category.all
    @category_count = Category.count
    @product_count = Product.count
  end
end
