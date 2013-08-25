class CartsController < ApplicationController
  before_action :set_cart, only: [:edit, :show, :update, :destroy]
  
  #http://api.rubyonrails.org/classes/ActiveSupport/Rescuable/ClassMethods.html
  #rescue_from Rescue exceptions raised in controller actions.
  #rescue_from works by receiving a series of exception classes or class names,
  #and a trailing :with option with the name of a method or a Proc object to be called to handle them
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  
  def index
   Cart.all 
  end
  
  def show
  end
  
  def new
    @cart = Cart.new
  end
  
  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to @cart, notice: "Successfully added to cart"
    else
      render 'new'
    end
  end
  
  def destroy
    @cart.destroy
    session[:card_id] = nil
    redirect_to products_path, notice: 'Redirected to products after emptying cart'
  end
  
  private
  
  def set_cart
    @cart = Cart.find(params[:id])
  end
  
  def cart_params
    params.require(:cart).permit(:user_id)
  end
  
  def invalid_cart
    logger.error "ERROR : Attempt to access invalid cart: '#{params[:id]}' "
  redirect_to products_path, notice: 'invalid cart or empty cart'
  end
end
