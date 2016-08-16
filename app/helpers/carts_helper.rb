module CartsHelper
  def sub_total
    @sub_total = if carts_items.count ==  0
      0
    else
      carts_items.collect{|book| book.price * book.quantity}.sum(:price).round(2)
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

  def coupon_code_value
    current_cart.coupon.nil? ? nil : current_cart.coupon.code 
  end

  def discount
    if current_cart.coupon.nil?
      0
    else
      current_cart.coupon.discount
    end
  end

  def sub_total_with_discount
    @discount = (sub_total * discount)/100 
    total = sub_total - @discount
    total.round(2)
  end
  
end
