class BooksController < ApplicationController
  load_and_authorize_resource
  def show
    #@ratings = @book.ratings.checking
    @ratings = RatingDecorator.decorate_collection(@book.ratings.checking)
    
    @book = Book.find(params[:id]).decorate
  end
end
