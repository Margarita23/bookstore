class OrdersController < ApplicationController
  include OrdersHelper
  load_and_authorize_resource
  
  def index
    if params[:view]
      @order = Order.find(params[:id])
    end
  end
  
  def new_order
    @order = Order.find(params[:id])
  end
  
  def show
  end
  
  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:id)
    end
end