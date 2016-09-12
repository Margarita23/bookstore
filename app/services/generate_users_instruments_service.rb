class GenerateUsersInstrumentsService  
  def initialize(user)
    @user = user
  end

  def call
    if !Address.exists?(user_billing_id: @user.id)
      billing_address = Address.create(user_billing_id: @user.id, first_name: @user.first_name, last_name: @user.last_name)
    end
    if !Address.exists?(user_shipping_id: @user.id)
      shipping_address = Address.create(user_shipping_id: @user.id, first_name: @user.first_name, last_name: @user.last_name)
    end
    if !Cart.exists?(user_id: @user.id) && !@user.admin
      cart = Cart.create(id: @user.id, user_id: @user.id)
    end
  end
  
  def facebook_info
    User.from_omniauth(request.env["omniauth.auth"])
  end
end