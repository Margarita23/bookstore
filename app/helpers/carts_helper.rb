module CartsHelper
  def sub_total
    @sub_total = if carts_items.count ==  0
      0
    else
      carts_items.collect{|book| book.price * book.quantity}.sum(:price)
    end
  end
  
  def quantity_incart
    @quantity = carts_items.sum(:quantity)
  end 
  
  def carts_items
    current_user.cart.line_items
  end
  
  def current_cart
    current_user.cart
  end

  def cart_fully
    if carts_items.count!=0
      "(#{quantity_incart})" + "$#{sub_total}"
    else
      t(:empty)
    end
  end
  
end
