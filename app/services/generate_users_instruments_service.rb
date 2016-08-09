class GenerateUsersInstrumentsService  
  def initialize(user)
    @user = user
  end

  def call
    if !Address.exists?(user_billing_id: @user.id)
      billing_address = Address.create(user_billing_id: @user.id)
    end
    if !Address.exists?(user_shipping_id: @user.id)
      shipping_address = Address.create(user_shipping_id: @user.id)
    end
    if !Cart.exists?(user_id: @user.id) && !@user.admin
      cart = Cart.create(id: @user.id, user_id: @user.id)
    end
  end
end