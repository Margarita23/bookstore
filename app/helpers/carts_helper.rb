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
end
