class AcceptedOrder
  include ActiveModel::Model
  attr_accessor (
    :billing
    :shipping
    :delivery
    :payment
    )
  
  #validates_presence_of :bill_f_name, :message => I18n.t(:'enter.billing_data.first_name'), if: :on_address_step
  #validates_presence_of :bill_l_name, :message => I18n.t(:'enter.billing_data.last_name'), if: :on_address_step
  #validates_presence_of :bill_street, :message => I18n.t(:'enter.billing_data.street'), if: :on_address_step
  #validates_presence_of :bill_city, :message => I18n.t(:'enter.billing_data.city'), if: :on_address_step
  #validates_presence_of :bill_country, :message => I18n.t(:'enter.billing_data.country'), if: :on_address_step
  #validates_presence_of :bill_zip, :message => I18n.t(:'enter.billing_data.zip'), if: :on_address_step
  #validates_presence_of :bill_phone, :message => I18n.t(:'enter.billing_data.phone'), if: :on_address_step
  
  validates_presence_of :ship_f_name, :message => I18n.t(:'enter.shipping_data.first_name'), if: :on_delivery_step #&& !:same_address
  #validates_presence_of :ship_l_name, :message => I18n.t(:'enter.shipping_data.last_name'), :unless => :same_address, if: :on_address_step
  #validates_presence_of :ship_street, :message => I18n.t(:'enter.shipping_data.street'), :unless => :same_address, if: :on_address_step
  #validates_presence_of :ship_city, :message => I18n.t(:'enter.shipping_data.city'), :unless => :same_address, if: :on_address_step
  #validates_presence_of :ship_country , :message => I18n.t(:'enter.shipping_data.country'), :unless => :same_address, if: :on_address_step
  #validates_presence_of :ship_zip , :message => I18n.t(:'enter.shipping_data.zip'), :unless => :same_address, if: :on_address_step
  #validates_presence_of :ship_phone , :message => I18n.t(:'enter.shipping_data.phone'), :unless => :same_address, if: :on_address_step
  
  

  def initialize (source_path)
    @source_path = source_path
  end
  
  
  
  def generate_number
    (0...ORDER_CHAR_NUM).map { (65 + rand(26)).chr }.join + (0...ORDER_DIG_NUM).map{rand(9)}.join
  end
  
  
end