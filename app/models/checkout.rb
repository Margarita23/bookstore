class Checkout 
  include ActiveModel::Model
  attr_accessor(
    :bill_f_name,
    :bill_l_name,
    :bill_street,
    :bill_city,
    :bill_country,
    :bill_zip,
    :bill_phone,

    :ship_f_name,
    :ship_l_name,
    :ship_street,
    :ship_city,
    :ship_country,
    :ship_zip,
    :ship_phone,
    
    :same_address,
 
    :delivery,
    
    :card_number,
    :card_code,
    :exp_month, 
    :exp_year,
    :current_step,
    :user_id
    )
  
  [:bill_f_name, :bill_l_name, :bill_street, :bill_city, :bill_country, :bill_zip, :bill_phone].each do |n|
    validates_presence_of n, :message => Proc.new {
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
    validates_presence_of n, :if => lambda { |o| o.same_address == false }, :message => Proc.new {
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
  
  validates :card_code, {
    presence: {message: "Enter cart code"}, 
    numericality: {only_integer: true, greater_than: 3, message: "Card code must contain only numbers"}
  }
  
  validates :card_number, {
    presence: {message: "Enter cart number"},  
    length: { is: 16, message: "Card number must be 16 digits"},
    numericality: {only_integer: true, message: "Card number must contain only numbers"}
  }
  
  def save
    if valid? && books_price != 0
      payment
      order
      billing
      shipping
      true
    else 
       false
    end
  end
  
  def order_id
    @order.id
  end
  
  def current_user
    user = User.all.find_by(id: user_id.to_i)
  end
  
  def get_delivery
    if !delivery.nil? || delivery == ""
      delivery = Delivery.all.find_by(id: self.delivery)
    else
      delivery = Delivery.first
    end
  end
  
  def books_price
    if current_user.cart.line_items.count != 0
      current_user.cart.line_items.collect{|book| book.price * book.quantity}.sum(:price)
    else
      0
    end
  end
  
  def total_price
    books_price.to_i + get_delivery.price.to_i
  end
  
private

  def order
    @order = Order.create(total_price: total_price, delivery_id: delivery, credit_card_id: @credit_card.id, number: generate_number, user_id: user_id) 
    get_line_items
  end
  
  def get_line_items
    current_user.cart.line_items.each do |l|
      l.order_id = order_id
      l.cart_id = nil
      l.save
    end
  end
  
  def generate_number
    (0...ORDER_CHAR_NUM).map { (65 + rand(26)).chr }.join + (0...ORDER_DIG_NUM).map{rand(9)}.join
  end

  def billing
    @bill_address = Address.create(first_name: bill_f_name, last_name: bill_l_name, street: bill_street, city: bill_city, country: bill_country, zip: bill_zip, phone: bill_phone, order_billing_id: @order.id)
  end
  
  def shipping
    if same_address
      #@ship_address = @bill_address
      #@ship_address.order_shipping_id = @order.id
      @ship_address = Address.create(first_name: bill_f_name, last_name: bill_l_name, street: bill_street, city: bill_city, country: bill_country, zip: bill_zip, phone: bill_phone, order_shipping_id: @order.id)
      @ship_address.save
    else
      @ship_address = Address.create(first_name: ship_f_name, last_name: ship_l_name, street: ship_street, city: ship_city, country: ship_country, zip: ship_zip, phone: ship_phone, order_shipping_id: @order.id)
    end
  end
  
  def payment
    if !CreditCard.all.exists?(:number => card_number)
      @credit_card = CreditCard.create(number: card_number, month: exp_month, year: exp_year, cvv: card_code, user_id: user_id)
    else
      @credit_card = CreditCard.all.find_by(number: card_number)
      @credit_card.user_id = user_id
      @credit_card.save
    end
  end
end