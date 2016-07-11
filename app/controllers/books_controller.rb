class BooksController < ApplicationController

  load_and_authorize_resource

  # GET /books/1
  def show
    @ratings = @book.ratings.where(:admin_checking => true)
  end
end
