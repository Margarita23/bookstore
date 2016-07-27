class BooksController < ApplicationController
  load_and_authorize_resource
  def show
    @ratings = @book.ratings.books_ratings
  end
end
