class Order < ActiveRecord::Base 
  include AASM
  aasm :column => 'state', :whiny_transitions => false do
    state :in_progress, :initial => true
    state :in_delivery
    state :completed

    event :shipped do
      transitions :from => :in_progress, :to => :in_delivery
    end

    event :complete do
      transitions :from => :in_delivery, :to => :completed
    end 
  end
  
  has_many :line_items, dependent: :destroy
  has_one :coupon
  belongs_to :user
  belongs_to :delivery
  belongs_to :credit_card
  has_one :billing_address, :class_name => "Address", :foreign_key => "order_billing_id", dependent: :destroy
  has_one :shipping_address, :class_name => "Address", :foreign_key => "order_shipping_id", dependent: :destroy
  
  validates_presence_of :total_price, :delivery_id, :number
  
  scope :in_progress, -> { where(state: :in_progress) }
  scope :in_delivery, -> { where(state: :in_delivery) }
  scope :completed, -> { where(state: :completed) }

  def order_sub_total
    self.line_items.collect{|book| book.price * book.quantity}.sum(:price)
  end
end
