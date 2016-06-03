class Delivery < ActiveRecord::Base
  has_many :orders
  #validates :method, :price presence: true
  validates :method, uniqueness: true
end
