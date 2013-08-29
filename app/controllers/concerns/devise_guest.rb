module DeviseGuest
  extend ActiveSupport::Concern
  
  included do
    helper_method :current_or_guest_user
  end
  
  module ClassMethods
  end
  
  #if user is logged in return current_user else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
         logging_in
         guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end
  
  #find guest_user object associated with the current session or create one
  def guest_user
    #cache the value the first time it is gotten
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
    
    rescue ActiveRecord::RecordNotFound  # if session[:guest_user_id] invalid
      session[:guest_user_id] = nil
      guest_user
  end
  
  private

#called once when the user logs in, insert any code your application needs
#hand of from guest_user to current_user

  def logging_in
    guest_carts = guest_user.carts.load
    
    guest_carts.each do |cart|
      #order.user_id = current_user.id
      #order.save!
      cart.update(user_id: current_user.id)
    end
  end

  def create_guest_user
    u = User.create(:email => "guest_#{Time.now.to_i}#{rand(99)}@example.com")
    u.guest = true if u.respond_to? :guest
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
  
  
end