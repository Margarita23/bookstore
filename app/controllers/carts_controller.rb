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
    items_ids = params[:ids].keys
    items_ids.each do |item_id|
      line_item = LineItem.find_by(id: item_id.to_i)
      line_item.update_attributes(quantity: params[:ids][:"#{item_id}"])
    end
    flash[:notice] = t(:quantity_changed)
    redirect_to :back
  end
  
  private 
  
  def all_items_ids
    params.require(:cart).permit(:ids)
  end
end