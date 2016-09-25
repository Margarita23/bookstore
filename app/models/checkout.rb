# FormObject Checkout
class Checkout
  include ActiveModel::Model
  include CartsHelper
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
    :user_id)

  validates_presence_of :bill_f_name, message: I18n.t(:'enter.billing_data.first_name'), if: :on_address_step
  validates_presence_of :bill_l_name, message: I18n.t(:'enter.billing_data.last_name'), if: :on_address_step
  validates_presence_of :bill_street, message: I18n.t(:'enter.billing_data.street'), if: :on_address_step
  validates_presence_of :bill_city, message: I18n.t(:'enter.billing_data.city'), if: :on_address_step
  validates_presence_of :bill_country, message: I18n.t(:'enter.billing_data.country'), if: :on_address_step
  validates_presence_of :bill_zip, message: I18n.t(:'enter.billing_data.zip'), if: :on_address_step 
  validates_presence_of :bill_phone, message: I18n.t(:'enter.billing_data.phone'), if: :on_address_step
  validates_numericality_of :bill_zip, only_integer: true, message: I18n.t(:'enter.billing_data.zip_only_numbers'), if: :on_address_step
  validates_numericality_of :bill_phone, message: I18n.t(:only_numbers), only_integer: true, if: :on_address_step

  validates_presence_of :ship_f_name, message: I18n.t(:'enter.shipping_data.first_name'), unless: :valid_ship_address
  validates_presence_of :ship_l_name, message: I18n.t(:'enter.shipping_data.last_name'), unless: :valid_ship_address
  validates_presence_of :ship_street, message: I18n.t(:'enter.shipping_data.street'), unless: :valid_ship_address
  validates_presence_of :ship_city, message: I18n.t(:'enter.shipping_data.city'), unless: :valid_ship_address
  validates_presence_of :ship_country, message: I18n.t(:'enter.shipping_data.country'), unless: :valid_ship_address
  validates_presence_of :ship_zip, message: I18n.t(:'enter.shipping_data.zip'), unless: :valid_ship_address
  validates_presence_of :ship_phone, message: I18n.t(:'enter.shipping_data.phone'), unless: :valid_ship_address
  validates_numericality_of :ship_zip, only_integer: true, message: I18n.t(:'enter.shipping_data.zip_only_numbers'), unless: :valid_ship_address
  validates_numericality_of :ship_phone, only_integer: true, message: I18n.t(:only_numbers), unless: :valid_ship_address

  validates_presence_of :card_code, message: I18n.t(:'enter.card_code'), if: :on_payment_step
  validates_numericality_of :card_code, only_integer: true, greater_than: 3, message: I18n.t(:'enter.code_numbers'), if: :on_payment_step

  validates_presence_of :card_number, message: I18n.t(:'enter.card_number'), if: :on_payment_step
  validates_length_of :card_number, is: 16, message: I18n.t(:'enter.16_digits'), if: :on_payment_step
  validates_numericality_of :card_number, only_integer: true, message: I18n.t(:'enter.card_only_num'), if: :on_payment_step

  def valid_ship_address
    :on_address_step && same_address == '1'
  end

  def save
    valid_new_quantity
    return false unless valid? && books_price > 0
    payment
    order
    get_coupon
    get_line_items
    billing
    shipping
    true
  end

  def valid_new_quantity
    order_items.each do |item|
      book = Book.find_by(id: item.book_id)
      new_quan = book.quantity - item.quantity
      item.update(quantity: book.quantity) if new_quan < 0
      item.destroy if book.quantity.zero?
    end
  end

  def current_user
    User.find_by(id: user_id.to_i)
  end

  def order_id
    @order.id
  end

  def order_items
    current_user.cart.line_items
  end

  def coupon
    current_user.cart.coupon
  end

  def coupon_discount
    coupon ? coupon.discount : 0
  end

  def get_delivery
    if delivery.blank?
      Delivery.first
    else
      Delivery.find_by(id: delivery)
    end
  end

  def books_price
    return 0 if order_items.count.zero?
    get_items_price(order_items)
  end

  def total_price
    total_discount = books_price.to_d * coupon_discount / 100
    total = books_price.to_d - total_discount + get_delivery.price.to_d
    total.round(2)
  end

  def order
    @order = Order.create(order_params)
  end

  def get_coupon
    if coupon
      @coupon = Coupon.find_by(id: coupon.id).reset_coupon_params(order_id)
    end
  end

  private

  def get_line_items
    order_items.each do |item|
      book_bought(item)
      item.update_attributes(order_id: order_id, cart_id: nil)
    end
  end

  def book_bought(item)
    book = Book.find_by(id: item.book_id)
    quantity = book.quantity - item.quantity
    bought = book.bought + item.quantity
    book.update_attributes(quantity: quantity, bought: bought)
  end

  def billing
    @bill_address = Address.create(billing_params)
  end

  def shipping
    address_params = if same_address == '1'
                       billing_params.merge(order_shipping_id: order_id, order_billing_id: nil)
                     else
                       shipping_params
                     end
    @ship_address = Address.create(address_params)
  end

  def payment
    if CreditCard.exists?(number: card_number)
      @credit_card = CreditCard.find_by(number: card_number)
      @credit_card.update_attributes(user_id: user_id)
    else
      @credit_card = CreditCard.create(credit_card_params)
    end
  end

  def on_address_step
    current_step == 'address' || current_step == 'confirm'
  end

  def on_delivery_step
    current_step == 'delivery' || current_step == 'confirm'
  end

  def on_payment_step
    current_step == 'payment' || current_step == 'confirm'
  end

  def on_confirm_step
    current_step == 'confirm'
  end

  def generate_number
    (0...ORDER_CHAR_NUM).map { (65 + rand(26)).chr }.join + (0...ORDER_DIG_NUM).map { rand(9) }.join
  end

  def order_params
    { total_price: total_price, delivery_id: get_delivery.id, credit_card_id: @credit_card.id, number: generate_number, user_id: user_id }
  end

  def credit_card_params
    { number: card_number, month: exp_month, year: exp_year, cvv: card_code, user_id: user_id }
  end

  def billing_params
    { first_name: bill_f_name, last_name: bill_l_name, street: bill_street, city: bill_city, country: bill_country, zip: bill_zip, phone: bill_phone, order_billing_id: order_id }
  end

  def shipping_params
    { first_name: ship_f_name, last_name: ship_l_name, street: ship_street, city: ship_city, country: ship_country, zip: ship_zip, phone: ship_phone, order_shipping_id: order_id }
  end
end
