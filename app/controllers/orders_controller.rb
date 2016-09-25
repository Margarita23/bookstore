# OrdersController
class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = current_user.orders
    @order = Order.find(params[:id]) if params[:view]
  end

  def new_order
  end

  def show
  end
end
