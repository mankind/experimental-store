class Product < ActiveRecord::Base
  mount_uploader :image_url, ImageUrlUploader 
  
  has_many :order_items
  belongs_to :user
  #validates :user_id, :inclusion => { :in => [true, false] }
  validates :price, presence: true, numericality: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  validate :user_should_be_a_seller
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  #removing any dollar signs. Then, with the value changed, super invokes the original price= method.
  def price=(input)
    input.delete!("$")

    super
  end
  
  
  private
  
   def user_should_be_a_seller
     if  self.user.seller == false
        errors.add('to create or manage a product, you must be a seller')
      end
   end
  
  #ensures that there are no line items referencing this product
  #A base error  adds an error to the base object instead of any particular attribute 
  #that is adds the error to something like an exact duplicate of the existing record, 
  #where the problem wasn't tied to any specific field but rather to the record as a whole
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      #errors[:base] << "Error message"    #this an alternative way
      errors.add(:base, 'An line-item or A customer has an item in the cart')
      return false
    end
  end
  
  
  
end
