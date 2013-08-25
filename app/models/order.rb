class Order < ActiveRecord::Base
  
  validates :order_items, presence: true
 
  has_many :order_items, dependent: :destroy
  belongs_to :user
  belongs_to :address
  
  def total
    order_items.map(&:subtotal).sum
  end
  
  #ability to add lineitems ie items in the cart to order
  #add_orders_items_from_cart(cart) says for item transfered from the cart to the order we need to do 3 things
  #first, using cart.order_items.each, we take every order_items from that cart and "give them the name" item 
  #secondly, #set the cart_id to nil to prevent the item being called when we destroy the cart.
  #thirdly, using << item we add the item itself to the order_items collection for the order
  def add_orders_items_from_cart(cart)
    cart.order_items.each do |item|        
      #item.cart_id = nil  
      Rails.logger.debug("item is: #{item.inspect}")
      order_items << item
    end
  end
  
  
end
