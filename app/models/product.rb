class Product < ActiveRecord::Base
  has_many :order_items
  belongs_to :store
  validates :price, presence: true, numericality: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  #removing any dollar signs. Then, with the value changed, super invokes the original price= method.
  def price=(input)
    input.delete!("$")
    super
  end
  
  private
  
  #If this hook method returns false, the row will not be destroyed
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  
end
