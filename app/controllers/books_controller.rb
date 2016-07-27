class BooksController < ApplicationController
  load_and_authorize_resource
  def show
    @ratings = @book.ratings.checking
  end
end
