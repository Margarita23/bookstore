class TempOrderontroller < ApplicationController

  
  def create
    @order = Order.new(order_params)
   
    @order.save
    redirect_to wizard_path(:address)
  end

end