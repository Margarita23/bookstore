# LineItemsController
class LineItemsController < ApplicationController
  include CartsHelper
  load_and_authorize_resource

  def create
    @line_item = CheckingQuantityService.new(params[:book_id], params[:new_quantity], current_cart).call
    if @line_item.nil?
      flash[:alert] = t(:books_not_added)
    else
      @line_item.save
      flash[:notice] = SetLessQuantityService.new(@line_item, params[:book_id]).call
    end
    redirect_to :back
  end

  def destroy
    @line_item.destroy
    redirect_to :back
    flash[:notice] = t(:remove_books)
  end

  private

  def line_item_params
    params.permit(:book_id)
  end
end
