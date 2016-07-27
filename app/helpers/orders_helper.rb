module OrdersHelper
  def orders
    Order.user_orders(current_user)
  end
  
  #def shopping
   # Book.all
  #end
end