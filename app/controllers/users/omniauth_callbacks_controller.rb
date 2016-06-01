class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController 
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      @billing_address = Address.new()
      @shipping_address = Address.new()
      @billing_address.user_billing_id = resource.id
      @shipping_address.user_shipping_id = resource.id
      @billing_address.save
      @shipping_address.save
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