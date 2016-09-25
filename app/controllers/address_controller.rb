class AddressController < ApplicationController
  load_and_authorize_resource

  def update
    @address = Address.find(params[:id]) 
    if @address.update(address_params)      
      flash[:notice] = I18n.t(:'addresses.updated')
    else
      flash[:alert] = I18n.t(:'addresses.not_updated')
    end
    redirect_to :back
  end

  private
    def address_params
      params.permit(:first_name, :last_name, :street, :city, :country, :zip, :phone)
    end
end
