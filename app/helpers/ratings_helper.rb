module RatingsHelper
  def rating_author
    if !@rating.user.billing_address.first_name.blank?
      "#{@rating.user.billing_address.first_name} #{@rating.user.billing_address.last_name}"
    else
      @rating.user.email
    end
  end
end