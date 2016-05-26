class Checkout
  include ActiveModel::Model
  include Virtus.model
  
  attr_reader :address
  attr_reader :delivery
  #attr_reader :order
  
  attribute :bill_f_name, String
  attribute :bill_l_name, String
  attribute :bill_street, String
  attribute :bill_city, String
  attribute :bill_country, String
  attribute :bill_zip, Integer
  attribute :bill_phone, String
  
  attribute :ship_f_name, String
  attribute :ship_l_name, String
  attribute :ship_street, String
  attribute :ship_city, String
  attribute :ship_country, String
  attribute :ship_zip, Integer
  attribute :ship_phone, String
  attribute :use_same_address, Boolean, :default => 1

  attribute :user
  attribute :total_price, Decimal
  
  attribute :delivery, Integer, :default => 1
  attribute :card_number, String
  attribute :card_code, Integer
  attribute :exp_date, String
  attribute :current_step
  
  validates_presence_of :bill_f_name
  validates_presence_of :bill_l_name
  #validates :bill_street, presence: true
  #validates :bill_city, presence: true
  #validates :bill_country, presence: true
  #validates :bill_zip, presence: true
  #validates :bill_phone, presence: true
  
  #validates :ship_f_name, presence: true
  #validates :ship_l_name, presence: true
  #validates :ship_street, presence: true
  #validates :ship_city, presence: true
  #validates :ship_country, presence: true
  #validates :ship_zip, presence: true
  #validates :ship_phone, presence: true
  
  #validates :card_number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 16 }
  #validates :card_code, presence: true, numericality: { only_integer: true, greater_than: 3 }
  
   def current_step
    @current_step || steps.first
  end
  
  def next_step
    if valid?
      self.current_step = steps[steps.index(current_step)+1]
    else
      self.errors.messages
    end
  end
  
  def address_step
    if valid?
      self.current_step = steps[steps.index("address")]
    else
      self.errors.messages
    end
   
  end
  
  def delivery_step
     if valid?
       self.current_step = steps[steps.index("delivery")]
    else
      self.errors.messages
    end
  end
  
  def payment_step
     if valid?
       self.current_step = steps[steps.index("payment")]
    else
      self.errors.messages
    end
  end
  
   def confirm_step
     if valid?
       self.current_step = steps[steps.index("confirm")]
    else
      self.errors.messages
    end
  end
  
  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end

  def steps
    %w[address delivery payment confirm]
  end
  
  def persisted?
    false
  end
 
  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    @order = Order.create!(total_price: @total_price, user_id: @user.id, delivery_id: @delivery)
    bill_address
    ship_address
  end
  
  private
  
  def bill_address
    @billing_address = Address.create!(first_name: @bill_f_name, last_name: @bill_l_name, order_billing_id: @order.id)
  end
  
  def ship_address
    if @use_same_address == "1"
      @shipping_address = Address.create!(first_name: @bill_f_name, last_name: @bill_l_name, order_shipping_id: @order.id)
    else
      @shipping_address = Address.create!(first_name: @ship_f_name, last_name: @ship_l_name, order_shipping_id: @order.id)
    end
  end
end