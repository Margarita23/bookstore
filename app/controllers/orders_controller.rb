class OrdersController < ApplicationController
  
  def index
    @orders = Order.all.where(:user_id => current_user.id)
    @orders_prog = @orders.where(:state => :in_progress)
    @orders_ship = @orders.where(:state => :shipped)
    @orders_comp = @orders.where(:state => :completed)
    if params[:view]
      @order = Order.find(params[:id])
    end
    
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:id)
    end
  
end