class CreditCard < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  validates :number, uniqueness: true
end
