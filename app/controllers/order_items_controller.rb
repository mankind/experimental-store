class OrderItemsController < ApplicationController
  before_action :load_order, only: [:create]
  before_action :set_order_item, only: [:show, :edit, :destroy]
  respond_to :html, :json

  #we don't need the :index, :show and :new actions, so to be removed

  def index
    @order_items = OrderItem.all
    respond_with @order_items
  end
  
  def show
  end
  
  #def new
   # @order_item = OrderItem.new
  #end

  def edit
    
  end
  
   
# since the form that gets created by the 'Add to cart' in products/index uses a button_to helper, 
# and button_helper doesn’t nest data in an order_item hash, it simply submits to the URL provided.
# we will need to change this @order_item = OrderItem.new(order_item_params)
#also, we build the order_item through the relationship with the order 
# with find_or_initialize, we want to look first look for order_item with the matching product_id first
# += increases the product quantity by 1 if in the order & If it’s not in the order, add it to the order with quantity 1
  # for  += to work as described above, the default value for quantity must be set to zero in the database
  
  def create
    #@order_item = OrderItem.new(product_id: params[:product_id], order_id: @order_id)
    #@order_item = @order.order_items.new(product_id: params[:product_id], quantity: 1)
    
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])
    @order_item.quantity += 1
   
    if @order_item.save
      redirect_to  @order, {notice: 'Successfully added product to cart.' }
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
      redirect_to @order_item.order, {notice: 'successfully updated the order item.' }
    else
      render 'edit'
    end
  end
  
  def destroy
    @order_item.destroy
    #redirect_to products_path
    redirect_to @order_item.order
  end
  
  private
  
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end
  
  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :quantity)
  end
  
  #users orders are loaded via load_order method
  # In it, we avoid using exceptions for control flow as in the commented out code below
  #so we redesign the method commented out below  to not rely on begin/rescue/end
  # the status: "unsubmitted" will only set the status if it is initializing a new object
  #user_id: session[:user_id] associates a user with the order, if one is logged-in
  def load_order
    @order = Order.find_or_initialize_by(id: session[:order_id], status: 'unsubmitted')
    #@order.user_id = current_user.try(:id) 
    @order.user = current_or_guest_user
    if @order.new_record?
      @order.save!
      session[:order_id] = @order.id
    end
  end
  
=begin
  # tries to find the Order with the :order_id in the session
  # raise an ActiveRecord::RecordNotFound error If the session hash does not have a key named :order_id
  #The rescue statement watches for this error and, if it occurs, creates a new Order
  def load_order
    begin
      @order = Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      @order = Order.create(status: 'unsubmitted')
      session([:order_id]) = @order.id 
  end
  
=end
end
