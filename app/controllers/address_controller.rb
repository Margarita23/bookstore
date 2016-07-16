class AddressController < ApplicationController
  
  load_and_authorize_resource

  # POST /addresss
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to @address
    else
      redirect_to :back
    end
  end

  # PATCH/PUT /addresss/1
  def update
    @address = Address.find(params[:id]) 
    if @address.update(first_name: params[:first_name], 
                      last_name: params[:last_name], 
                      street: params[:street], 
                      city: params[:city], 
                      country: params[:country], 
                      zip: params[:zip], 
                      phone: params[:phone])
      @address.save
      redirect_to :back   
      flash[:notice] = t(:'address.updated')
    else
      redirect_to :back
      flash[:alert] = t(:'addres.not_updated')
    end
  end

  private
    def address_params
      params.require(:address).permit(:first_name, :last_name, :street, :city, :country, :zip, :phone )
    end
  
  def checkout_form_params
    params.require(:checkout_form).permit!(:first_name, :last_name)
  end

end
