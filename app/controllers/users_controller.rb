class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_filter :authenticate_user!, except: [:new, :create]
 
  respond_to :html, :json
  
  def index
    @users = User.all
    respond_with @users
  end
  
  def show
    
  end
  
  def edit
    @user = User.find(params[:id])
    respond_with @user
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in :user, @user #immediately signs in newly registerd user
      load_current_cart if session[:guest_user_id] != nil
      #current_user.move_guest_cart_to_user(@user) #if current_user && current_user.guest?
      redirect_to @user, {notice: 'User was created'}
    else
      render 'new'
    end
  end
  
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    if @user.update(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in :user, @user, :bypass => true 
      redirect_to @user, {notice: 'Your user details were updated'}
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
  
    redirect_to users_path, {notice: 'A user was removed'}
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
