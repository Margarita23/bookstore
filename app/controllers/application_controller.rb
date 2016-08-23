class ApplicationController < ActionController::Base 
  before_action :set_locale
  helper_method :current_user 
  protect_from_forgery
  
  def set_locale
    I18n.locale = current_user.try(:locale) || I18n.default_locale
  end
  
  def change_language
    current_user.update_attribute(:locale, params[:locale]) if !current_user.nil?
    redirect_to :back
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.new_user_session_path, :alert => exception.message
  end

end
