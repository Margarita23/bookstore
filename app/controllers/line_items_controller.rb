class LineItemsController < ApplicationController
  include CartsHelper
  load_and_authorize_resource

  def create
    book = Book.find_by(id: params[:book_id])
    return redirect_to root_path, alert: t(:books_not_added) if book.nil?
    @line_item = ItemWithCheckingQuantityService.new(book, params[:new_quantity], current_cart).call
    return redirect_to :back, alert: t(:books_not_added) if @line_item.nil?
    if @line_item.save
      flash[:notice] = SetLessQuantityService.new(@line_item, book).call
    #else
    #  flash[:alert] = t(:books_not_added)
    #  redirect_to :back
    end
    redirect_to :back
  end

  def destroy
    @line_item.destroy
    redirect_to :back
    flash[:notice] = t(:remove_books)
  end

  private
  #def set_line_item
  #  @line_item = LineItem.find(params[:id])
  #end
  def line_item_params
    params.permit(:book_id)
  end
end