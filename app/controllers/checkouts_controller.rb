class CheckoutsController < ApplicationController
  
  helper CheckoutsHelper
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm

  def show   
    @checkout = Checkout.new(checkout_params)
    @checkout.current_step = session[:last_step] 
    @checkout.user_id = current_user.id 
    if future_step?(session[:last_step].to_sym)
      session[:last_step] = step
    elsif @checkout.valid?
      session[:last_step] = step
    end
    render checkout_path(session[:last_step]), method: :get
  end
  
  def create
    @checkout = Checkout.new(session[:checkout])
    @checkout.user_id = current_user.id 
    if @checkout.save
      redirect_to new_order_show_path(@checkout.order_id)
      flash[:notice] = t(:order_saved)
    else
      redirect_to checkout_path(:confirm), method: :get  
      flash[:alert] = error_msg
    end
  end
  
  private
  
  def checkout_params
    session[:checkout] ||= {}
    session[:checkout].deep_merge!(params[:checkout]) if params[:checkout]
    session[:checkout]
  end
  
  def error_msg
    sentences = t(:ord_not_save)
    @checkout.errors.each do |attr, msg|
      sentences << msg
    end
    sentences
  end
end