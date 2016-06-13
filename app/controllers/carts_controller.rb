class CartsController < ApplicationController
  include CartsHelper
  before_action :set_cart, only: [:show, :update, :destroy] 

  
  # GET /carts/1
  # GET /carts/1.json
  def show
    #@cart = Cart.new
  end
  
  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    if @cart.update(cart_params)
      redirect_to @cart
      flash[:notice] = 'Cart was successfully updated.'
    else
      redirect_to :back
      flash[:alert] = 'Cart was not updated. Check data'
    end
  end
  
  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    redirect_to shopping_url
    flash[:notice] = 'Cart was successfully destoyed.'
  end
  
  def empty_cart
    current_user.cart.line_items.destroy_all
    redirect_to cart_url
    flash[:notice] = 'Your shopping cart has been cleared'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.fetch(:cart, {})
    end
    
end
