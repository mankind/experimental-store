class ApplicationController < ActionController::Base
  include DeviseGuest
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

=begin
  def current_user
  if params[:user_id].blank?
    redirect_to user_session_path
  else
    User.find(params[:user_id])
    
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end   
 end
 
=end
  
  private
  
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
  
end
