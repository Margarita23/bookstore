class CreditCard < ActiveRecord::Base
  
  attr_accessor :cardNumber, :cardCVV, :cardExpiryMonth, :cardExpiryYear
  
  validates :cardNumber, :cardCVV, :cardExpiryMonth, :cardExpiryYear  presence: true
  
end
