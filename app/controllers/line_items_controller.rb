class LineItemsController < ApplicationController
  include CurrentCart
  
  before_action :set_cart, only: [:create]
  
  load_and_authorize_resource

  # GET /line_items/1
  def show
  end
  
  # POST /line_items
  def create
    book = Book.find(params[:book_id])
    line_item = set_quantity(book)
    if line_item.save
      flash[:notice] = qty_less_books(line_item, book)
      redirect_to :back
    else
      flash[:alert] = t(:books_not_added)
      redirect_to :back
    end
  end

  # PATCH/PUT /line_items/1
  def update
    if check_quantity(@line_item)
      @line_item.quantity = @quan
      if @line_item.update(id: @line_item.id)
        flash[:notice] = t(:quan_changed)
        redirect_to :back
      end
    else
      flash[:alert] = t(:quan_not_changed)
      redirect_to :back
    end
  end

  # DELETE /line_items/1
  def destroy
    @line_item.destroy
    redirect_to :back
    flash[:notice] = t(:remove_books)
  end

  private
  
  def qty_less_books(item, book)
    if item.quantity > book.quantity
      item.quantity = book.quantity 
      item.save
      t(:books_in_store_1) + "#{book.quantity}" + t(:books_in_store_2)
      else
      t(:books_added)
    end
  end
  
  def set_quantity(book)
    item = Cart.find_by(id: params[:cart_id]).line_items.find_by(book_id: book)
    if check_params
      quan = params[:new_quantity]
      if !item.nil?
        item.quantity = item.quantity.to_i + quan.to_i
        item
      else
        item = @cart.line_items.build(book: book)
        item.quantity = quan.to_i
        item.price = book.price
        item
      end 
    end
  end
  
  def check_params
    params[:new_quantity].to_i > 0 && !params[:new_quantity].nil?
  end
  
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
    

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.permit(:book_id, :cart_id)
    end
end