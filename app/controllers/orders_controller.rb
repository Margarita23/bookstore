class OrdersController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @orders = Order.all.where(:user_id => current_user.id)
    if params[:view]
      @order = Order.find(params[:id])
    end
  end
  
  def new_order
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