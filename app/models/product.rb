class Product < ActiveRecord::Base
  has_many :order_items
  validates :price, presence: true, numericality: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  #removing any dollar signs. Then, with the value changed, super invokes the original price= method.
  def price=(input)
    input.delete!("$")
    super
  end
  
end
