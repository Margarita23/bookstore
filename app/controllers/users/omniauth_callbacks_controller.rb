# Facebook Authentication
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      GenerateUsersInstrumentsService.new(@user).call
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      #redirect_to new_user_registration_url
      redirect_to user_facebook_omniauth_authorize_path
    end
  end
end
