class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  def self.create_customer_in_stripe(params)
   #if valid?
    
    #self.order_id = params[:order_id]
    
    my_user = User.find(params[:user_id])
    self.user_id = my_user
    
    if self.user.stripe_card_token.blank?
        user_email = self.user.email
        customer = Stripe::Customer.create(email: user_email, card: params[:token])
        self.user.stripe_card_token = customer.id
      
        self.card.last4  = customer.card.last4
        self.card_type = customer.card.type
        self.card_exp_month = customer.card.exp_month
        self.card_exp_year = customer.card.exp_year
      
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
