class RatingsController < ApplicationController
  #before_action :set_rating, only: [:show, :edit, :update, :destroy]
  
  load_and_authorize_resource :book
  load_and_authorize_resource :rating, :through => :book

  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    authorize! :create, Rating
    @book = Book.find(params[:book_id])
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    
    #if current_user
      @rating = Rating.new(rating_params)
      @rating.book_id = params[:book_id]
      @rating.user_id = current_user.id
      if @rating.save
        redirect_to book_path(params[:book_id])
        flash[:notice] = "Your review was successfully saved"
      else
        redirect_to new_book_rating_path(params[:book_id])
        flash[:alert] = "Check all of fields. Your review is not save."
      end
    #else
      #redirect_to new_user_session_path
      #flash[:alert] = "Review can leave only registered users"
    #end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    if @rating.update(rating_params)
      redirect_to @rating 
      flash[:notice] = 'Rating was successfully updated.'
    else
      redirect_to :back
      flash[:notice] = 'Rating was not updated. Check data'
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    redirect_to ratings_url
    flash[:notice] = 'Rating was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:headline, :review, :book_id, :user_id, :grade )
    end
end
