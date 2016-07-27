class CartsController < ApplicationController
  include CartsHelper
  
  load_and_authorize_resource
  
  # GET /carts/1
  def show
    session[:last_step] ||= "address"
  end
  
  def destroy
    return redirect_to cart_url, alert: I18n.t(:already_empty) if carts_items.empty?
    carts_items.destroy_all
    redirect_to cart_url
    flash[:notice] = t(:'cart_cleared')
  end
end
