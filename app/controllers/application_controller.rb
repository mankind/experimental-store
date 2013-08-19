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
end
