class OrderItemsController < ApplicationController
  before_action :load_current_cart, only: [:create]
  before_action :set_order_item, only: [:show, :edit, :destroy]
  respond_to :html, :json

  def show
  end

  def edit
  end
  
  
  def create    
    @order_item = @cart.order_items.find_or_initialize_by(product_id: params[:product_id])
    @order_item.quantity += 1
    Rails.logger.debug("The order_item contains : #{@order_item.inspect}")    
    if @order_item.save
      redirect_to  @cart, {notice: 'Successfully added product to cart.' }
    else
      render 'new'
    end
    
  end
  
  #instead of giving users an error message when they change quantity to zero, we just delete that order. 
  def update
    @order_item = OrderItem.find(params[:id])
    if  params[:order_item][:quantity].to_i == 0
       @order_item.destroy
       redirect_to  products_path, {notice: 'Item was deleted from your cart.' }
    elsif  @order_item.update(order_item_params)
      redirect_to @order_item.cart, {notice: 'successfully updated the order item.' }
    else
      render 'edit'
    end
  end
  
  def destroy
    @order_item.destroy
    redirect_to @order_item.cart
  end
  
  private
  
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end
  
  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :quantity)
  end
  
end
