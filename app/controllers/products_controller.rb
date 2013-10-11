class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource only: [ :create, :edit, :destroy]
  respond_to :html, :json
  
  def index
    @products = Product.all
    respond_with @products
  end
  
  def show    
  end
  
  def new
    @product = Product.new   
  end
  
  def edit
  end
  
  def create 
    @user = User.find_by(id: current_user.id)
   
    @product = @user.products.build(product_params)
    
    if @product.save
      redirect_to products_path, {notice: 'Product was successfully created.' }
      
    else
      render action: 'new'
      
    end
  end
  
  def update
    if @product.update(product_params)
      redirect_to @product, {notice: 'Product was successfully updated.'} 
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @product.destroy
    redirect_to products_path
  end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  
  # note that :remote_image_url_url refers to us appending :remote_ before :image_url db field
  #and adding _url after :image_url db field to allow for carrierwave's remote upload
  def product_params
    params.require(:product).permit(:title, :price, :stock, :description, :image_url, :user_id,  :remote_image_url_url)
  end
end
