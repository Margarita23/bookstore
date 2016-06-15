class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    if resource.save
      if !Address.exists?(user_billing_id: resource.id)
        @billing_address = Address.new()
        @billing_address.user_billing_id = resource.id
        @billing_address.save
      end
      if !Address.exists?(user_shipping_id: resource.id)
        @shipping_address = Address.new()
        @shipping_address.user_shipping_id = resource.id
        @shipping_address.save
      end
      if !Cart.exists?(user_id: resource.id) && !resource.admin
        @cart = Cart.new(id: resource.id, user_id: resource.id)
        @cart.save
      end
      resource.guest = false
      resource.save
    end
  end

  def update
    super
  end
  
  def destroy
    super
  end
  
end 