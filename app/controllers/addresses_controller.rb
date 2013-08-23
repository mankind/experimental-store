class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  
  def new
    @address = current_user.addresses.new
  end
  
  def create
    @address = Address.new(address_params
      if address.save
        redirect_to order_path(session[:order_id]), notice: 'Address was successfully created.'
      else
         render action: 'new'
      end        
  end 
    
  def update
    if @address.update(address_params)
       redirect_to @address, notice: 'Address was successfully updated.'
    else
      render action: 'edit'
    end
   end
   
    def destroy
      @address.destroy
      redirect_to addresseses_path
    end
    
  
  
  private
  
  def set_address
    @address = Address.find(params[:id])
  end
  
  def address_params
    params(:address).permit(:line1, :line2, :city, :state, :zip, :store_id, :customer_id, :user_id)
  end
end
