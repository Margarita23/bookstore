module CurrentCart
  extend ActiveSupport::Concern
  def set_cart
    @cart = current_user.cart
    if @cart.nil?
      @cart = Cart.create(id: current_user.id, user_id: current_user.id)
    end
  end
end