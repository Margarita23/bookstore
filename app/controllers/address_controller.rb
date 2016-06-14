class AddressController < ApplicationController
  
  load_and_authorize_resource

  # POST /addresss
  # POST /addresss.json
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to @address
    else
      redirect_to :back
    end
  end

  # PATCH/PUT /addresss/1
  # PATCH/PUT /addresss/1.json
  def update
    @address = Address.find(params[:id]) 
    if @address.update(first_name: params[:first_name], last_name: params[:last_name], street: params[:street], city: params[:city], country: params[:country], zip: params[:zip], phone: params[:phone])
      @address.save
      redirect_to :back   
      flash[:notice] = 'Address was successfully updated.'
    else
      redirect_to :back
      flash[:alert] = 'Address was not updated. Check data. (Zip and phone number must be only digits)'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @billing_address = address.find(params[:id])
      @shipping_address = address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:first_name, :last_name, :street, :city, :country, :zip, :phone )
    end
  
  def checkout_form_params
    params.require(:checkout_form).permit!(:first_name, :last_name)
  end

end
