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
 
#https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
#if you happen to have before_filter :authenticate_user! in your ApplicationController you will need to use before_filter :store_location
#rather than after_filter :store_location and make sure to place it ahead of before_filter :authenticate_user!
  after_filter :store_location

  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" && \
        request.fullpath != "/users/sign_up" && \
        request.fullpath != "/users/password" && \
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
  
  private
  
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
