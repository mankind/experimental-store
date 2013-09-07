class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  def create_customer_in_stripe(params)
   #if valid?
    
    #self.order_id = params[:order_id]
    
    my_user = User.find(params[:user_id])
    self.user = my_user
    
    if self.user.stripe_card_token.blank?
        user_email = self.user.email
        customer = Stripe::Customer.create(email: user_email, card: params[:token])
      
        Rails.logger.debug("customer object has: #{customer.inspect}")
        Rails.logger.debug("cards object has: #{customer.cards.data.inspect}")
        Rails.logger.debug("first cards object has: #{customer.cards.first.inspect}")
        Rails.logger.debug("last4 from first cards object has: #{customer.cards.first.last4.inspect}")
        Rails.logger.debug("last4 from card data object has: #{customer.cards.data[0].last4.inspect}")

=begin
        
        self.user.stripe_card_token = customer.id
        card  = customer.cards.first
        #self.card_last4  = card["last4"]
         self.card_last4  = card.last4
        #self.card_type = card["type"]
        self.card_type = card.type
        self.card_exp_month = card["exp_month"]
        self.card_exp_year = card["exp_year"]


=end
      card = customer.cards.data
      self.last4 = card[0].last4
      self.user.save
     end
     
     self.save!
    
    #end  closes the valid line
    
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  
  end

=begin

  def charge_customer
    charge = Stripe::Charge.create(
      amount: (self.order.total_price*100).to_i,
      currency: "usd",
      customer: self.user.stripe_card_token,
      description: "Charges for your order"
    )
  end


=end
  

end
