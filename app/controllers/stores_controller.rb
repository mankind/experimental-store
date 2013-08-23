class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  
  private
  def set_store
    @store = Store.find(params[:id])
  end
  
  def store_params
    params.require(:store).permit(:name, :role)
  end
end
