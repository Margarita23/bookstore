class CheckoutController < ApplicationController
  layout "checkout_steps"
  include Wicked::Wizard
  
  steps :address, :delivery, :payment, :confirm, :complete
  
  
  
  def show
    @order = current_user.temp_order
    if @order.nil?
      @order = TempOrder.create(user_id: current_user.id)  
    end
    render_wizard
  end
  
  def update
  end
  
end
