class Order < ActiveRecord::Base
 
  has_many :order_items, dependent: :destroy
  belongs_to :user
  belongs_to :address
  
  def total
    order_items.map(&:subtotal).sum
  end
  
  #ability to add lineitems ie items in the cart to order
  def add_orders_items_from_cart(cart)
    cart.order_items.each do |item|
      item.cart_id = nil
      order_items << item
    end
  end
  
  
end
