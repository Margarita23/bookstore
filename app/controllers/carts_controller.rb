class CartsController < ApplicationController
  include CartsHelper
  load_and_authorize_resource

  def show
    session[:last_step] ||= "address"
  end
  
  def destroy
    return redirect_to cart_url, alert: I18n.t(:already_empty) if carts_items.empty?
    carts_items.destroy_all
    redirect_to cart_url
    flash[:notice] = t(:'cart_cleared')
  end
  
  def update_items
    return redirect_to root_path if @cart.nil? || params[:ids].nil?
    @cart.update_items_quantity(params[:ids])
    @cart.coupon = Coupon.find_by(code: params[:coupon][:code])
    flash[:alert] = t(:coupon_code_is_not_right) if invalid_coupon_code
    flash[:notice] = t(:quantity_changed)
    redirect_to :back
  end
  
  private
  
  def invalid_coupon_code
    params[:coupon][:code].to_s.strip.length != 0 && @cart.coupon.nil?
  end
end