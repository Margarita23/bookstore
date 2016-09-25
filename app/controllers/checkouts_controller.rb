# Checkout
class CheckoutsController < ApplicationController
  helper CheckoutsHelper
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm

  def show
    checking_user_with_items
    @checkout = Checkout.new(checkout_params)
    session[:last_step] = step if can_go_to_next_step
    render checkout_path(session[:last_step]), method: :get
  end

  def create
    checking_user_with_items
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

  def checking_user_with_items
    return redirect_to new_user_session_path, alert: I18n.t(:authorize_please) if current_user.new_record?
    return redirect_to shopping_path, alert: I18n.t(:order_must_contain_books) unless current_user.cart.line_items.present?
  end

  def can_go_to_next_step
    future_step?(session[:last_step].to_sym) || @checkout.valid?
  end

  def checkout_params
    session[:checkout] ||= {}
    session[:checkout].deep_merge!(params[:checkout]) if params[:checkout]
    session[:checkout]
  end
end
