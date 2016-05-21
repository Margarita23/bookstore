class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  
  before_action :set_cart, only: [:create]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.find(params[:cart_id])
  end
  
  

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    book = Book.find(params[:book_id])
    @line_item = LineItem.find_by(book_id: book.id)
    quan = params[:new_quantity].nil? ? 1 : params[:new_quantity]
    if !@line_item.nil?
      @line_item.quantity = @line_item.quantity.to_i + quan.to_i
    else
      @line_item = @cart.line_items.build(book: book)  
      @line_item.quantity = quan.to_i
      @line_item.price = book.price 
    end
       
    if @line_item.save
      redirect_to :back
    else
      flash.now[:notice] = "Book can not be add to cart, please enter information."
render :new
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    quan = params[:new_quantity].nil? ? 1 : params[:new_quantity]
    @line_item.quantity = quan
    respond_to do |format|
      if @line_item.update(id: @line_item.id)
        format.html { redirect_to @line_item.cart, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to  @line_item.cart, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:book_id, :cart_id)
    end
end
