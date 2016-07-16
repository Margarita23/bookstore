class LineItem < ActiveRecord::Base
  
  belongs_to :book
  belongs_to :cart
  
  validates :quantity, {
    presence: true,
    :numericality => {:greater_than => 0, :message => I18n.t(:book_quan)}
  }
  
end
