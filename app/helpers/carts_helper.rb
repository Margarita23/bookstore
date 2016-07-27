module CartsHelper
  def sub_total
    if current_user.cart.line_items.count ==  0
      @sub_total = 0
    else
      @sub_total = current_user.cart.line_items.collect{|book| book.price * book.quantity}.sum(:price)
    end
  end
  
  def quantity_incart
    @quantity = current_user.cart.line_items.sum(:quantity)
  end 
  
  def carts_items
    current_user.cart.line_items
  end
  
  def current_cart
    current_user.cart
  end
  
  def cart_fully
    if current_cart.line_items.count!=0  
      "(#{quantity_incart})" + "$#{sub_total}"
    else
      t(:empty)
    end
  end
  
end
