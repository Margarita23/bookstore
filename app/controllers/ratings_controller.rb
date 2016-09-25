# RatingsController
class RatingsController < ApplicationController
  load_and_authorize_resource :book
  load_and_authorize_resource :rating, through: :book

  def show
    @rating = Rating.find(params[:id]).decorate
  end

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.grade = params[:score]
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
    params.require(:rating).permit(:headline, :review, :book_id, :user_id)
  end
end
