class ApplicationController < ActionController::Base
  include DeviseGuest
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  
  private
  
  def current_store
    current_user.store  
  end
  helper_method :current_store
  
  #users orders are loaded via load_order method
  # In it, we avoid using exceptions for control flow as in the commented out code below
  #so we redesign the method commented out below  to not rely on begin/rescue/end
  # the status: "unsubmitted" will only set the status if it is initializing a new object
  #user_id: session[:user_id] associates a user with the order, if one is logged-in
  def load_current_cart
    @cart = Cart.find_or_initialize_by(id: session[:cart_id])
    #@order.user_id = current_user.try(:id) 
    @cart.user = current_or_guest_user
    if @cart.new_record?
      @cart.save!
      session[:cart_id] = @cart.id
    end
  end
  
end
