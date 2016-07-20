class RatingsController < ApplicationController
  
  load_and_authorize_resource :book
  load_and_authorize_resource :rating, :through => :book

  # GET /ratings
  def index
    @ratings = Rating.where(admin_checking: true)
  end

  # GET /ratings/1
  def show
  end

  # GET /ratings/new
  def new
    @book = Book.find(params[:book_id])
    @rating = Rating.new
  end
  
  # POST /ratings
  def create
    @rating = Rating.new(rating_params)
    @rating.book_id = params[:book_id]
    @rating.user_id = current_user.id
    if @rating.save
      redirect_to book_path(@rating.book_id)
      flash[:notice] = t(:rating_saved)
    else
      redirect_to new_book_rating_path(params[:book_id])
      flash[:alert] = t(:rating_not_saved)
    end
  end
  
  private
    def rating_params
      params.require(:rating).permit( :headline, :grade, :review)
    end
end
