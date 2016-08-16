class CouponsController < ApplicationController
  load_and_authorize_resource
  def update
    @coupon = get_coupon
    if @coupon.update_attributes(user_id: current_user)
      flash[:alert] = @coupon
      redirect_to "back"
    end
  end
  
  def get_coupon
    if Coupon.exists?(code: params[:code]) && Coupon.find_by(code: @coupon_code).order_id.nil?
      @coupon = Coupon.find_by(code: @coupon_code)
    end
    @coupon
  end  
end