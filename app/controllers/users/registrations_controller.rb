class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    if resource.save
      @billing_address = Address.new()
      @shipping_address = Address.new()
      @billing_address.user_billing_id = resource.id
      @shipping_address.user_shipping_id = resource.id
      @billing_address.save
      @shipping_address.save
    end
  end

  def update
    super
  end
  
  def destroy
    super
    if resource.destroy
      @billing_address = Address.find(user_billing_id: resource.id)
      @shipping_address = Address.find(user_shipping_id: resource.id)
      @billing_address.each do |address|
        address.destroy
      end
      @shipping_address.each do |address|
        address.destroy
      end
    end
  end
  
end 