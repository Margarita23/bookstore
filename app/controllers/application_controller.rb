class ApplicationController < ActionController::Base 
  before_action :set_locale
  helper_method :current_user 
  protect_from_forgery
  
  def set_locale
    I18n.locale = current_user.try(:locale) || I18n.default_locale
  end
  
  def change_language
    current_user.update_attribute(locale, params[:locale])
    redirect_to :back
    rescue ActionController::RedirectBackError
    redirect_to root_path
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

end
