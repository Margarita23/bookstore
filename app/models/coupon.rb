class Coupon < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  belongs_to :cart
end
