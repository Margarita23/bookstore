class LineItemsController < ApplicationController
  include CurrentCart
  
  before_action :set_cart, only: [:create]
  
  load_and_authorize_resource

  # GET /line_items/1
  def show
  end
  
  # POST /line_items
  def create
    @book = Book.find(params[:book_id])
    @line_item = Cart.find(params[:cart_id]).line_items.find_by(book_id: @book)
    if params[:new_quantity].to_i > 0 && !params[:new_quantity].nil?
      @quan = params[:new_quantity]
      @line_item = check_nil(@cart, @line_item, @book, @quan)
      if less_or_more(@line_item, @book)
        if @line_item.save
          flash[:alert] = "Sorry, but the stock only #{@book.quantity} book(s). In your basket was(were) added all this book(s)"
          redirect_to :back
        end
      else
        @line_item.save
        flash[:notice] = "Book(s) was(were) added in your cart"
        redirect_to :back
      end
    else
      flash[:alert] = "Book can not be add to your cart, please enter information."
      redirect_to :back
    end
  end

  # PATCH/PUT /line_items/1
  def update
    if check_quantity(@line_item)
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
  def destroy
    @line_item.destroy
    redirect_to :back
    flash[:notice] = 'Book(s) was remove from your cart'
  end

  private
  
    def check_quantity(item)
      book = Book.find_by(id: item.book_id)
      if params[:new_quantity].to_i > 0 && !params[:new_quantity].nil?
        if book.quantity >= params[:new_quantity].to_i
          @quan = params[:new_quantity]
          true 
        else
          false
        end
      end
    end
  
    def less_or_more(item, book)
      if item.quantity > book.quantity
        item.quantity = book.quantity
        true
      else
        false
      end  
    end
  
    def check_nil(cart, item, book, quantity)
      if !item.nil?
        item.quantity = item.quantity.to_i + quantity.to_i
        item
      else
        item = cart.line_items.build(book: book)
        item.quantity = quantity.to_i
        item.price = book.price
        item
      end 
    end

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.permit(:book_id, :cart_id)
    end
end