class RatingDecorator < Draper::Decorator
  delegate_all
  
  def author_name
    first_name.present? ? "#{first_name} #{last_name}" : email
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
