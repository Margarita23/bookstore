class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    if resource.persisted?
      generate_users_instruments(resource)
    end
  end

  def update
    super
  end
  
  def destroy
    super
  end
  
  private
  
  def generate_users_instruments(user)
    if !Address.exists?(user_billing_id: user.id)
      @billing_address = Address.create(user_billing_id: user.id)
    end
    if !Address.exists?(user_shipping_id: user.id)
      @shipping_address = Address.create(user_shipping_id: user.id)
    end
    if !Cart.exists?(user_id: user.id) && !user.admin
      @cart = Cart.create(id: user.id, user_id: user.id)
    end
    user.guest = false
    user.save
  end
  
end 