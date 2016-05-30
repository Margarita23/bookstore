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

  attribute :checkbox_use_same_address, Boolean, :default => false

  attribute :user
  attribute :total_price, Decimal
  
  attribute :delivery, Integer, :default => 1
  attribute :card_number, String
  attribute :card_code, Integer
  attribute :exp_month, String
  attribute :exp_year, String
  attribute :current_step
  
  [:bill_f_name, :bill_l_name, :bill_street, :bill_city, :bill_country, :bill_zip, :bill_phone].each do |n|
    validates_presence_of n, :if => lambda { |o| o.current_step == "address"}, :message => Proc.new {
      case
        when n == :bill_f_name then "Enter first name for billing address" 
        when n == :bill_l_name then "Enter last name for billing address"
        when n == :bill_street then "Enter street for billing address"
        when n == :bill_city then "Enter city for billing address"
        when n == :bill_country then "Enter country for billing address"
        when n == :bill_zip then "Enter zip for billing address"
        when n == :bill_phone then "Enter phone for billing address"
      end
    }
  end
  
  [:ship_f_name, :ship_l_name, :ship_street, :ship_city, :ship_country, :ship_zip, :ship_phone].each do |n|
    validates_presence_of n, :if => lambda { |o| o.current_step == "address" && o.checkbox_use_same_address == false }, :message => Proc.new {
      case
        when n == :ship_f_name then "Enter first name for shipping address" 
        when n == :ship_l_name then "Enter last name for shipping address"
        when n == :ship_street then "Enter street for shipping address"
        when n == :ship_city then "Enter city for shipping address"
        when n == :ship_country then "Enter country for shipping address"
        when n == :ship_zip then "Enter zip for shipping address"
        when n == :ship_phone then "Enter phone for shipping address"
      end
    }
  end
          
  validates :bill_phone, :numericality => {:only_integer => true, message: "Billing phone must contain only numbers"}
  validates :ship_phone, :numericality => {:only_integer => true, message: "Shipping phone must contain only numbers"}
  
  validates :card_code, {
    presence: {message: "Enter cart code"}, 
    numericality: {only_integer: true, greater_than: 3, message: "Card code must contain only numbers"},
   :if => lambda { |o| o.current_step == "payment" }
  }
  
  validates :card_number, {
    presence: {message: "Enter cart number"},  
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
    if @checkbox_use_same_address
      @ship_f_name = @bill_f_name
      @ship_l_name = @bill_l_name
      @ship_street = @bill_street
      @ship_city = @bill_city
      @ship_country = @bill_country
      @ship_zip = @bill_zip
      @ship_phone = @bill_phone
    end
    @checkbox_use_same_address
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
          
  def order
    @order.id
  end

  private

  def persist!
    @order = Order.create!(total_price: @total_price, user_id: @user.id, delivery_id: @delivery)
    
    @order.number = generate_number
    while Order.exists?(:number => @order.number) do
      @order.number = generate_number
    end
    @order.save
    
    bill_address
    ship_address
  end
          
  def generate_number
    (0...ORDER_CHAR_NUM).map { (65 + rand(26)).chr }.join + (0...ORDER_DIG_NUM).map{rand(9)}.join
  end
  
  def bill_address
    @billing_address = Address.create(first_name: @bill_f_name, last_name: @bill_l_name, street: @bill_street, city: @bill_city, country: @bill_country, zip: @bill_zip, phone: @bill_phone,  order_billing_id: @order.id)
  end

  def ship_address
    @shipping_address = Address.create!(first_name: @ship_f_name, last_name: @ship_l_name, street: @ship_street, city: @ship_city, country: @ship_country, zip: @ship_zip, phone: @ship_phone,  order_shipping_id: @order.id)
  end
end