class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :load_current_cart, only: [:new, :create]
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
  end
  
  def create
    @order = Order.new(order_params)
    @order.add_order_items_from_cart(@cart)
    @order.status = "completed"
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      #redirect_to @order
      #redirect_to products_path
      redirect_to confirm_order_path(@order), notice: 'Order was successfully updated.'
      
    else
      render 'new'
    end
  end
  
  def update
    if @order.update(order_params.merge)
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
    @order = current_store.order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:user_id, :status, :store_id, :customer_id)
  end
  
  #implemeting abilty to add line ites to an order
  def add_order_items_from_cart(cart)
    cart.order_items.each do |item|
      item.cart_id = nil
      order_items << item
    end
  end
  
end
