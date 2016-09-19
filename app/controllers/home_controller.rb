class HomeController < ApplicationController
  def bestsellers
    @bestsellers = BookDecorator.decorate_collection(Book.bestsellers)
  end
  
  def shop
    @categories = Category.all
    @books = Book.all
  end
end