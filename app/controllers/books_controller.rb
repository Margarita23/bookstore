class BooksController < ApplicationController

  load_and_authorize_resource

  # GET /books/1
  def show
    @ratings = @book.ratings.books_ratings
  end

end
