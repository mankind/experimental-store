class OrdersController < ApplicationController
    
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :load_current_cart, only: [:new, :create]
 
  #before_action :authenticate_user!
  
  #skips the authentication for the mentioned methods
  #skip_before_action :authenticate_user!, only: [:new, :create]   
  
  respond_to :html, :json
  
  def index
    @orders = Order.all
    respond_with @orders
  end
  
  def show
  end
  
  def edit
  end
  
  def new
    @order = Order.new
    @order.user_id = current_user.id
  end
  
  def create
    @order = Order.new(user_id: current_user.id, address_id: current_user.addresses(&:id))
   
    @order.add_orders_items_from_cart(@cart)
    a = @order.create_customer(:token => params[:stripe_card_token], user_id: current_user.id)
    b = params[:stripe_card_token]
    @order.status = "completed"
    
    if @order.save
      
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
     
      redirect_to confirm_order_path(@order), notice: 'Order was successfully updated.'
    else
      render 'new'
    end
  end
  
  def update
    if @order.update(order_params) 
    else
      render 'edit'
    end   
   end
  
  def destroy
    @order.destroy
    redirect_to  products_path
  end
  
  def confirm
    
  end
  
  private
  
  def set_order
    @order = Order.find(params[:id])
    @address = Address.find_by(id: @order.user_id)
    
    @addresses =  current_user.addresses 
    respond_with @order  
  end
  
  def order_params
    params.require(:order).permit(:user_id, :address_id, :status)
  end
  
end
