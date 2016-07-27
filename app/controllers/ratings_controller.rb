class RatingsController < ApplicationController
  
  load_and_authorize_resource :book
  load_and_authorize_resource :rating, :through => :book

  #def index
   # @ratings = Rating.checking
  #end

  def show
  end

  def new
    @rating = Rating.new
  end

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
