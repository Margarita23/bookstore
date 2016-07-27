class LineItemsController < ApplicationController
  include CartsHelper
  include LineItemsHelper
  load_and_authorize_resource

  def show
  end

  def create
    book = Book.find_by(id: params[:book_id])
    return redirect_to root_path, alert: t(:books_not_added) if book.nil?
    @line_item = set_quantity(book, params[:new_quantity])
    if @line_item.save
      flash[:notice] = qty_less_books(@line_item, book)
      redirect_to :back
    else
      flash[:alert] = t(:books_not_added)
      redirect_to :back
    end
  end

  def update
    book = Book.find_by(id: @line_item.book_id)
    return redirect_to root_path, alert: t(:quan_not_changed) if book.nil?
    if check_quantity(@line_item, book, params[:new_quantity])
      @line_item.quantity = params[:new_quantity]
      if @line_item.update(id: @line_item.id)
        flash[:notice] = t(:quan_changed)
        redirect_to :back
      end
    else
      flash[:alert] = t(:quan_not_changed)
      redirect_to :back
    end
  end

  def destroy
    @line_item.destroy
    redirect_to :back
    flash[:notice] = t(:remove_books)
  end

  private
  
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.permit(:book_id)
  end
end