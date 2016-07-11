class CheckoutsController < ApplicationController
  
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm

  def show   
    session[:checkout] ||= {}
    session[:checkout].deep_merge!(params[:checkout]) if params[:checkout]
    @checkout = Checkout.new(session[:checkout])
    session[:last_step] = params[:id]
    @checkout.current_step = session[:last_step] 
    @checkout.user_id = current_user.id 
    render_wizard 
  end
  
  def create
    @checkout = Checkout.new(session[:checkout])
    @checkout.user_id = current_user.id 
    if @checkout.save
      redirect_to new_order_show_path(@checkout.order_id)
      flash[:notice] = "Order has been saved"
    else
      redirect_to checkout_path(:confirm), method: :get
      dodick = "Order has not been saved. Please, enter information. "
      @checkout.errors.each do |attr, msg|
        dodick << msg + ". " 
      end
      flash[:alert] = dodick 
    end
  end
end