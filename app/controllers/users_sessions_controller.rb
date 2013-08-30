#https://github.com/plataformatec/devise/wiki/How-To:-Upgrade-to-Devise-2.2
#http://stackoverflow.com/questions/14319868/ember-js-with-devise-on-rails-application-406-not-acceptable-on-sign-up
class UsersSessionsController < Devise::SessionsController
    respond_to  :html, :json
  
  #load_current_cart is called to transfer cart from guest to signed_in user
  #load_current_cart is defined in ApplicationController
    def create
     super
        
      if sign_in(@user) 
        load_current_cart if session[:guest_user_id] != nil
      end
  end
end
