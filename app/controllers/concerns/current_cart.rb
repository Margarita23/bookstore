module CurrentCart
  extend ActiveSupport::Concern
  def set_cart
    #return redirect_to new_user_session_path, alert: I18n.t(:authorize_please) if current_user.nil?
    @cart = current_user.cart
    if @cart.nil?
      @cart = Cart.create(id: current_user.id, user_id: current_user.id)
    end
  end
end