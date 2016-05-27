class CartsController < ApplicationController
  include CartsHelper
  before_action :set_cart, only: [:show, :update, :destroy] 

  # GET /carts/1
  # GET /carts/1.json
  def show
  end
  
  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def empty_cart
    current_user.cart.line_items.destroy_all
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    empty_cart
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to shopping_url, notice: 'Cart was successfully cleared.' }
      format.json { head :no_content }
    end
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
