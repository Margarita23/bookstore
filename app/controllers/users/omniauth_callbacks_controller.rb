class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController 
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      generate_users_instruments(@user)
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
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