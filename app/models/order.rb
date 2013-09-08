class Order < ActiveRecord::Base
  
  validates :order_items, presence: true
 
  has_many :payments
  has_many :order_items, dependent: :destroy
  belongs_to :user
  belongs_to :address
  
  attr_accessor :stripe_card_token
  after_save  :update_payment
  
  def total
    @b = order_items.map(&:subtotal).sum
    @c = (@b*100).to_i
    Rails.logger.debug("total method in Order model has total of : #{@c.inspect}")
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
      total
    end
  end
  
  def create_customer(params)
    @payment_info = Payment.new
    @payment_info.create_customer_in_stripe(params)
    @payment_info.order = self
    Rails.logger.debug("create_customer has: #{params.inspect}") 
    Rails.logger.debug("user id is: #{params[:user_id].inspect}")
    Rails.logger.debug("stripe token is: #{params[:token].inspect}")
    #Rails.logger.debug("create_customer has: #{@payment_info.order.inspect}") 
  end
  
  def me(params)
    Rails.logger.debug("me is: #{params.inspect}")
  end
  
  def update_payment
    @payment_info.order_id = self.id
    @payment_info.save!
    d  = @c
    @payment_info.charge_customer(d)
    Rails.logger.debug("payment order id is: #{@payment_info.order_id.inspect}") 
    Rails.logger.debug("update_payment method in Order model has total of : #{@c.inspect}")
  end
end
