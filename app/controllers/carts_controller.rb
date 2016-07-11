class CartsController < ApplicationController
  include CartsHelper
  
  load_and_authorize_resource
  
  # GET /carts/1
  def show
    session[:last_step] ||= "address"
  end
  
  def destroy
    current_user.cart.line_items.destroy_all
    redirect_to cart_url
    flash[:notice] = 'Your shopping cart has been cleared'
  end
end
