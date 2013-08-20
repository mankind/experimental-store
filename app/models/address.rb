class Address < ActiveRecord::Base
  validates :line1, :city, :state, :zip,  presence: true
    #state must be a two-letter uppercase abbreviation.
  validates :state, format: {with: /[A-Z]{2}/}
    # zipcode should be exactly 5 characters that are only digits
  validates :zip, format: {with:  /\d{5}/}
  
  has_many :orders
  belongs_to :user
  
  #builds an array of the attributes you want to display, then join them together with a comma and a space
  def to_s
    [line1, line2, "#{city}, #{state} #{zip}"].compact.join(", ")
  end
  
end
