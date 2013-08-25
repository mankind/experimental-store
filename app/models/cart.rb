class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy
  
  
  def total
    order_items.map(&:subtotal).sum
  end
end
