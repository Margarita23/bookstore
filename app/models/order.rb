class Order < ActiveRecord::Base 
  include AASM
  
  aasm :column => 'state', :whiny_transitions => false do
    state :in_progress, :initial => true
    state :shipped
    state :completed

    event :ship do
      transitions :from => :in_progress, :to => :shipped
    end

    event :complete do
      transitions :from => :shipped, :to => :completed
    end 
  end
  
  has_many :line_items
  belongs_to :user
  belongs_to :delivery
  belongs_to :credit_card
  has_one :billing_address, :class_name => "Address", :foreign_key => "order_billing_id"
  has_one :shipping_address, :class_name => "Address", :foreign_key => "order_shipping_id"
  
  validates_presence_of :total_price, :delivery_id, :number

end
