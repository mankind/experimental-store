module ProductsHelper
  def print_price(price)
    # "$#{price}"
    
    #enures $2.00 doesn't appear as $2.0 which happens with the above but doesn't internationalize
    # format("$%.2f", price)
    
    #this rails helper internationalizes
    number_to_currency(price)
  end
  
  #if no item in stock return the "out of stock" line
  #if there is enough stock to fulfil the requested number, return the 'in stock' line
  #if available stock is less than the requested number return "insufficient stock'
   def print_stock(stock, requested = 1)
    if stock == 0
      content_tag(:span, "Out of Stock", class: "in_stock")
    elsif stock >= requested
      content_tag(:span, "In Stock (#{stock})", class: "in_stock")
    else
      content_tag(:span, "Insufficient stock (#{stock})", class: "low_stock")
    end
  end
  
  
end
