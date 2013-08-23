class CartsController < ApplicationController
  before_action :set_cart, only: [:edit, :update, :destroy]
  
  respond_to :html, :json
  
  def index
    @carts = Cart.all
    respond_with @carts
  end
  
  def show
     @cart = Cart.find(params[:id])
     rescue ActiveRecord::RecordNotFound
       logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to products_url, notice: 'Invalid cart'
  end
  
  def new
    Cart.new
  end
  
  def edit
    
  end

  def destroy
    @cart =  load_current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to products_path
  end
  
  private
  
  def set_cart
   @cart = Cart.find_by(id: session[:cart_id])    
  end
  
  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
