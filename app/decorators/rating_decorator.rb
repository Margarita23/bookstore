class RatingDecorator < Draper::Decorator
  delegate_all
  
  def author_name
    if !first_name.blank?
      "#{first_name} #{last_name}"
    else
      email
    end
  end
  
  def first_name
    object.user.billing_address.first_name
  end
  
  def last_name
    object.user.billing_address.last_name
  end
  
  def email
    object.user.email
  end

end
