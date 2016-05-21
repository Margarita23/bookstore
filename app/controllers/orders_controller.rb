class OrdersController < ApplicationController
  
  def new
    @order = Forms::Order.new  
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Forms::Order.new(params[:order].merge(:user_id => current_user.id))
    if @order.save
      redirect_to root_path
    else
      render :action => "new"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:total_price, :completed)
    end
end
