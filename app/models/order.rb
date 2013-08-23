class Order < ActiveRecord::Base
  
  validates :store_id, :customer_id,  presence: true, numericality: true
  validates :status, presence: true
 
  belongs_to :user
  belongs_to :address
  belongs_to :store
  belongs_to :customer
  has_many :order_items
  
  def total
    order_items.map(&:subtotal).sum
  end
  
  
end
