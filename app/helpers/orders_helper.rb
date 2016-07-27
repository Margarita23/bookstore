module OrdersHelper
  def orders
    Order.user_orders(current_user)
  end
end