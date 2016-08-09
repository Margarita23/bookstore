module CheckoutsHelper
  def bill_first_name_value
    current_user.billing_address.first_name || session[:checkout]['bill_f_name']
  end
  
  def bill_last_name_value
    current_user.billing_address.last_name || session[:checkout]['bill_l_name']
  end
  
  def bill_street_value
    current_user.billing_address.street || session[:checkout]['bill_street']
  end
  
  def bill_city_value
    current_user.billing_address.city || session[:checkout]['bill_city']
  end
  
  def bill_country_value
    current_user.billing_address.country || session[:checkout]['bill_country']
  end
  
  def bill_zip_value
    current_user.billing_address.zip || session[:checkout]['bill_zip']
  end
  
  def bill_phone_value
    current_user.billing_address.phone || session[:checkout]['bill_phone']
  end
  
  def ship_first_name_value
    current_user.shipping_address.first_name || session[:checkout]['ship_f_name']
  end
  
  def ship_last_name_value
    current_user.shipping_address.last_name || session[:checkout]['ship_l_name']
  end
  
  def ship_street_value
    current_user.shipping_address.street || session[:checkout]['ship_street']
  end
  
  def ship_city_value
    current_user.shipping_address.city || session[:checkout]['ship_city']
  end
  
  def ship_country_value
    current_user.shipping_address.country || session[:checkout]['ship_country']
  end
  
  def ship_zip_value
    current_user.shipping_address.zip || session[:checkout]['ship_zip']
  end
  
  def ship_phone_value
    current_user.shipping_address.phone || session[:checkout]['ship_phone']
  end
  
  def card_number_value
    current_user.cart.card_number || session[:checkout]['ship_phone']
  end
  
  def hidden_card_number
    if !@checkout.card_number.nil?
      hidden_number = "**** **** **** " + @checkout.card_number[-4,4]
    else
      hidden_number = ''
    end
  end
  
  def checkout_errors_message(resource)
    resource.errors.map{|attr,msg| msg}.join
  end
end