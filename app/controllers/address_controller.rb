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
    if @address.update(address_params)
      @address.save
      redirect_to :back   
      flash[:notice] = I18n.t(:'addresses.updated')
    else
      redirect_to :back
      flash[:alert] = I18n.t(:'addresses.not_updated')
    end
  end

  private
    def address_params
      address_params = {first_name: params[:first_name], 
                      last_name: params[:last_name], 
                      street: params[:street], 
                      city: params[:city], 
                      country: params[:country], 
                      zip: params[:zip], 
                      phone: params[:phone]}
    end
end
