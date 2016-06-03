class CreditCard < ActiveRecord::Base
  has_many :orders
  validates :number, uniqueness: true
end
