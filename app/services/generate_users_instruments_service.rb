# GenerateUsersInstrumentsService
class GenerateUsersInstrumentsService
  def initialize(user)
    @user = user
  end

  def call
    unless Address.exists?(user_billing_id: @user.id)
      Address.create(user_billing_id: @user.id, first_name: @user.first_name, last_name: @user.last_name)
    end
    unless Address.exists?(user_shipping_id: @user.id)
      Address.create(user_shipping_id: @user.id, first_name: @user.first_name, last_name: @user.last_name)
    end
    Cart.create(id: @user.id, user_id: @user.id) unless checking_cart
  end

  def checking_cart
    Cart.exists?(user_id: @user.id) && @user.admin
  end
end
