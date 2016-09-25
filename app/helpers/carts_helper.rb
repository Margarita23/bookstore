# CartsHelper
module CartsHelper
  def sub_total
    return 0 if carts_items.count.zero?
    @sub_total = get_items_price(carts_items)
  end

  def get_items_price(items)
    items.collect { |book| book.price * book.quantity }.sum(:price).round(2)
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
    return t(:empty) if carts_items.count.zero?
    "(#{quantity_incart})" + "$#{sub_total}"
  end

  def coupon_code_value
    current_cart.coupon.nil? ? nil : current_cart.coupon.code
  end

  def discount
    current_cart.coupon.nil? ? 0 : current_cart.coupon.discount
  end

  def sub_total_with_discount
    @discount = (sub_total * discount) / 100
    total = sub_total - @discount
    total.round(2)
  end
end
