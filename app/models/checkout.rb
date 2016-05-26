class Checkout
  include ActiveModel::Model
  include Virtus.model
  
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
  
  #???????????????????????????What's up with checkout???
  attribute :checkbox_use_same_address, Boolean, :default => "faulse"

  attribute :user
  attribute :total_price, Decimal
  
  attribute :delivery, Integer, :default => 1
  attribute :card_number, String
  attribute :card_code, Integer
  attribute :exp_date, String
  attribute :current_step
  
  validates_presence_of :bill_f_name, message: "Enter your first name for billing address", :if => lambda { |o| o.current_step == "address" }
  validates_presence_of :bill_l_name, message: "Enter your last name for billing address", :if => lambda { |o| o.current_step == "address" }
  
  validates_presence_of :ship_f_name, message: "Enter your first name for shipping address", :if => lambda { |o| o.current_step == "address" && o.checkbox_use_same_address == "0"}
  validates_presence_of :ship_f_name, message: "Enter your last name for shipping address", :if => lambda { |o| o.current_step == "address" && o.checkbox_use_same_address == "0"}
  
  validates :card_code, {
    presence: true, 
    numericality: {only_integer: true, greater_than: 3, message: "Card code must contain only numbers"},
   :if => lambda { |o| o.current_step == "payment" }
  }
  
  validates :card_number, {
    presence: true, 
    length: { is: 16, message: "Card number must be 16 digits"},
    numericality: {only_integer: true, message: "Card number must contain only numbers"},
   :if => lambda { |o| o.current_step == "payment" }
  }
     
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
  
  def check_same_address
    if @checkbox_use_same_address == "true"
      @checkout.ship_f_name = @bill_f_name
      @checkout.ship_l_name = @bill_l_name
      @checkout.ship_street = @bill_street
      @checkout.ship_city = @bill_city
      @checkout.ship_country = @bill_country
      @checkout.ship_zip = @bill_zip
      @checkout.ship_phone = @bill_phone
    end
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
  
  def bill_address
    @billing_address = Address.create(first_name: @bill_f_name, last_name: @bill_l_name, street: @bill_street, city: @bill_city, country: @bill_country, zip: @bill_zip, phone: @bill_phone,  order_billing_id: @order.id)
  end

  def ship_address
    if @checkbox_use_same_address == "true"
      @shipping_address = @billing_address
      @shipping_address.order_shipping_id = @order.id
      @shipping_address.save!
    else
      @shipping_address = Address.create!(first_name: @ship_f_name, last_name: @ship_l_name, street: @ship_street, city: @ship_city, country: @ship_country, zip: @ship_zip, phone: @ship_phone,  order_shipping_id: @order.id)
    end
  end
end