class AddressController < ApplicationController
  

  # GET /addresss/1
  # GET /addresss/1.json
  def show
  end

  # GET /addresss/new
  def new
    @address = Address.new
  end

  # GET /addresss/1/edit
  def edit
  end

  # POST /addresss
  # POST /addresss.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresss/1
  # PATCH/PUT /addresss/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresss/1
  # DELETE /addresss/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresss_url, notice: 'address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:title, :description, :price, :quantity)
    end
end
