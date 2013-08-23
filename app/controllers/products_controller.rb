class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
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
    @product = Product.new(product_params)
    #@product.store_id = current_store.id
    if @product.save
      redirect_to products_path, {notice: 'Product was successfully created.' }
      
    else
      #render 'new'
      render action: 'new'
      
    end
  end
  
  def update
    if @product.update(product_params)
      redirect_to @product, {notice: 'Product was successfully updated.'} 
      #redirect_to product_path, notice: 'Product was successfully updated.' 
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
    #@product = Product.find_by(id: params[:id])
  end
  
  def product_params
    params.require(:product).permit(:title, :price, :stock, :description, :image_url, :store_id)
  end
end
