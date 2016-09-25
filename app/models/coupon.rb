# Coupon
class Coupon < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  belongs_to :cart

  def reset_coupon_params(order_id)
    self.update(user_id: nil, cart_id: nil, order_id: order_id)
  end
end
