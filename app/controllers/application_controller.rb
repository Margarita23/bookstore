class ApplicationController < ActionController::Base 
  #before_action :authenticate_user!, only: [:show]
  
  helper_method :current_user 

  protect_from_forgery

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      
      if current_user.billing_address_id.nil? && current_user.shipping_address_id.nil?
        current_user.billing_address_id.build 
        current_user.shipping_address_id.build
      end 
      current_user
    else
      guest_user
    end
  end
  
  def guest_user(with_retry = true)

    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  private

    def create_guest_user
      u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
      u.save!(:validate => false)
      session[:guest_user_id] = u.id
      u
    end

end
