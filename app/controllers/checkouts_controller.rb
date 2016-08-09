class CheckoutsController < ApplicationController 
  helper CheckoutsHelper
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm

  def show   
    return redirect_to new_user_session_path, alert: I18n.t(:authorize_please) if current_user.nil?
    return redirect_to shopping_path, alert: I18n.t(:order_must_contain_books) if current_user.cart.line_items == []
    @checkout = Checkout.new(checkout_params)
    if future_step?(session[:last_step].to_sym) || @checkout.valid?
      session[:last_step] = step
    end
    render checkout_path(session[:last_step]), method: :get
  end
  
  def create
    return redirect_to new_user_session_path, alert: I18n.t(:authorize_please) if current_user.nil?
    return redirect_to shopping_path, alert: I18n.t(:order_must_contain_books) if current_user.cart.line_items == []
    @checkout = Checkout.new(checkout_params)
    if @checkout.save
      session[:checkout] = nil
      session[:last_step] = 'address'
      flash[:notice] = t(:order_saved)
      redirect_to new_order_show_path(@checkout.order_id)
    else
      redirect_to checkout_path(:confirm), method: :get 
    end
  end
  
  private
  
  def checkout_params
    session[:checkout] ||= {}
    session[:checkout].deep_merge!(params[:checkout]) if params[:checkout]
    session[:checkout]
  end
end