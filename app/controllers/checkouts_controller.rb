class CheckoutsController < ApplicationController
  
  helper CheckoutsHelper
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm

  def show   
    @checkout = Checkout.new(checkout_params)
    @checkout.current_step = session[:last_step] 
    @checkout.user_id = current_user.id 
    session[:past_step] = future_step?(session[:last_step].to_sym)
    if future_step?(session[:last_step].to_sym)
      session[:last_step] = step
    elsif @checkout.valid?
      #@checkout.save
      session[:last_step] = step
    #else
      #flash[:alert] = error_msg
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










  
 # def show
  #  @checkout = Checkout.new(checkout_params)
  #  @checkout.user_id = current_user.id
  #  @checkout.current_step = session[:last_step]
   # if @checkout.valid?
   #   session[:last_step] = step
  #    @checkout.current_step = session[:last_step]
  #    flash[:alert] = "VALID!!!!0o0"
  #  end
  #  render checkout_path(@checkout.current_step), method: :get
  #  flash[:alert] = "not_valid"
    
#  end
  
#  def create
#    @checkout = Checkout.new(checkout_params)
#    if @checkout.valid?
#      @checkout.save
#      session[:last_step] = params[:format]#@checkout.current_step
#      render checkout_path(session[:last_step]), method: :get
#    else
#      render checkout_path(session[:last_step]), method: :get
#    end
#  end
  
