class CheckoutController < ApplicationController
  layout "checkout_steps"
  include Wicked::Wizard
  
  steps :address, :delivery, :payment, :confirm, :complete
  
  
  
  def show
    
    render_wizard
  end
  
  def update
  end
  
end
