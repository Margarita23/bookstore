class LineItem < ActiveRecord::Base
  
  belongs_to :book
  belongs_to :cart
  
  validates :quantity, {
    presence: true,
    :numericality => {:greater_than => 0, :message => "Check quantity of books that you want to add to your cart"}
  }

end
