class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController 
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      if !Address.exists?(:user_billing_id => @user.id)
        @billing_address = Address.new()
        @billing_address.user_billing_id = @user.id
        @billing_address.save!
      end
      if !Address.exists?(:user_shipping_id => @user.id)
        @shipping_address = Address.new()
        @shipping_address.user_shipping_id = @user.id
        @shipping_address.save!
      end
      if !Cart.exists?(:user_id => @user.id)
        @cart = Cart.new()
        @cart.user_id = @user.id
        @cart.save
      end
      @user.guest = false
        @user.save
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
  
end