class CheckoutController < ApplicationController
  include CartsHelper
  
  def new
    session[:checkout_params] ||= {}
    session[:checkout_params].deep_merge!(params[:checkout]) if params[:checkout]
    @checkout = Checkout.new(session[:checkout_params])
    @checkout.current_step = session[:checkout_step]
    session[:delivery] = @checkout.delivery
    @delivery = Delivery.find(session[:delivery])
  end
  
  def create   
    set_values
    ### what about case when ???
    if params[:address_button]
      @checkout.address_step
      session[:checkout_step] = @checkout.current_step
      render 'new'

    elsif params[:delivery_button]
      @checkout.delivery_step
      session[:checkout_step] = @checkout.current_step
      render 'new'

    elsif params[:payment_button]
      @checkout.payment_step
      session[:checkout_step] = @checkout.current_step
      render 'new'

    elsif params[:confirm_button]
      @checkout.confirm_step
      session[:checkout_step] = @checkout.current_step
      render 'new'

    elsif @checkout.last_step?
      current_user.cart.line_items.destroy_all
      current_user.cart.destroy
        @checkout.save 
        session[:checkout_step]= nil
        flash[:notice] = "Order saved."
        redirect_to root_path
    else
      @checkout.next_step
      session[:checkout_step] = @checkout.current_step
      render 'new'
    end
  end
  
  def set_values
    session[:checkout_params].deep_merge!(params[:checkout]) if params[:checkout]
    @checkout = Checkout.new(session[:checkout_params])
    @checkout.current_step = session[:checkout_step]
    @checkout.user = current_user   
    if !@checkout.delivery.nil?
      @delivery = Delivery.find(@checkout.delivery) 
      @checkout.total_price =  sub_total + @delivery.price
    end
    @checkout.check_same_address
  end
  
end
