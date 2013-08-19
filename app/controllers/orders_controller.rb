class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
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
    if @order.save
      redirect_to @order
    else
      render 'new'
    end
  end
  
  def update
    if @order.update(order_params)
      redirect_to products_path
    else
      render 'edit'
    end   
   end
  
  def destroy
    @order.destroy
    redirect_to  products_path
  end
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:user_id, :status)
  end
  
end
