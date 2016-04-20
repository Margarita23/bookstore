class HomeController < ApplicationController
  
  def bestsellers
    @bestsellers = Book.order(:quantity)
  end
  
  def shop
    @shopping = Book.all
    @categories_shop = Category.all
  end
  
end
