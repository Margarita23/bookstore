class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books/1
  # GET /books/1.json
  def show
    @ratings = @book.ratings.where(:admin_checking => true)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.bought = 0 
    if @book.save
      redirect_to @book
      flash[:notice] = 'Book was successfully created.'
    else
      redirect_to :back
      flash[:alert] = 'Book was not created. Check data'
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if @book.update(book_params)
      redirect_to @book
      flash[:notice] = 'Book was successfully updated.'
    else
      redirect_to :back
      flash[:alert] = 'Book was not updated. Check data'
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    redirect_to books_path 
    flash[:notice] = 'Book was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :description, :price, :quantity)
    end
end
