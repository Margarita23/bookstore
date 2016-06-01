class HomeController < ApplicationController
  before_action :set_cart, only: [:create]
  def bestsellers
    @bestsellers = Book.order(:bought).first(10)
  end
  
  def shop
    @shopping = Book.all
    @categories_shop = Category.all
  end
  
end
