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
    @line_item = Cart.find(params[:cart_id]).line_items.find_by(book_id: book)
    if check_quantity
      if !@line_item.nil?
        @line_item.quantity = @line_item.quantity.to_i + @quan.to_i
      else
        @line_item = @cart.line_items.build(book: book)
        @line_item.quantity = @quan.to_i
        @line_item.price = book.price
      end 
      if @line_item.quantity > book.quantity
          @line_item.quantity = book.quantity
        if @line_item.save
          flash[:alert] = "Sorry, but the stock only #{book.quantity} book(s). In your basket was(were) added all this book(s)"
          redirect_to :back
        end
      else @line_item.save
        flash[:notice] = "Book(s) was(were) added in your cart"
        redirect_to :back
      end  
    else
      flash[:alert] = "Book can not be add to your cart, please enter information."
      redirect_to :back
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    if check_quantity
      @line_item.quantity = @quan
      if @line_item.update(id: @line_item.id)
        flash[:notice] = "Books quantity was changed"
        redirect_to :back
      end
    else
      flash[:alert] = "Books quantity can not change, please enter information."
      redirect_to :back
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
  
    def check_quantity
      if params[:new_quantity].to_i > 0 && !params[:new_quantity].nil?
        @quan = params[:new_quantity]
        true 
      else
        false
      end
    end

    def update_cout
      @line_items
      @line_item.quantity = @quan
      if @line_item.update(id: @line_item.id)
        flash[:notice] = "Books quantity was changed"
        redirect_to :back
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:book_id, :cart_id)
    end
end
