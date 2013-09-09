class ApplicationController < ActionController::Base
  include DeviseGuest
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  #https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
  #if you happen to have before_filter :authenticate_user! in your ApplicationController you will need to use before_filter :store_location
  #rather than after_filter :store_location and make sure to place it ahead of before_filter :authenticate_user!

  after_filter :store_location
  
  rescue_from  CanCan::AccessDenied do |exception|
     flash[:error] = "Access denied"
    redirect_to products_url
  end
  
  #temprary work-around for cancan gem to work with rails-4
  #https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  #store last url - this is needed for post-login redirect to whatever the user last visited.
  def store_location
    if (request.fullpath != "/users/new" && \
        request.fullpath != "/d/users/sign_in" && \
        request.fullpath != "/d/users/sign_up" && \
        request.fullpath != "/d/users/password" && \
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
    
    # store last url as long as it isn't a /users path
    #session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    #session[:previous_url] || root_path
    session[:previous_url] || super
  end

  # Notice it is important to cache the ability object so it is not
    # recreated every time.
    #def current_ability
     # @current_ability ||= Ability.new(current_user)
   # end
  
  private
  
  #current_or_guest_user is defined in controllers/concerns/devise_guest.rb
  #users orders are loaded via load_current_cart method
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
