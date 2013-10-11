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
  
  def add_orders_items_from_cart(cart)
    cart.order_items.each do |item|         
      Rails.logger.debug("item is: #{item.inspect}")
      order_items << item
      total
    end
  end
  
  def create_customer(params)
    @payment_info = Payment.new
    @payment_info.create_customer_in_stripe(params)
    @payment_info.order = self 
  end
  
  def me(params)
    Rails.logger.debug("me is: #{params.inspect}")
  end
  
  def update_payment
    @payment_info.order_id = self.id
    @payment_info.save!
    d  = @c
    @payment_info.charge_customer(d)
  end
end
