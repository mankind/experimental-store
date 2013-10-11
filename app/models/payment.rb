class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  def create_customer_in_stripe(params)
  
    my_user = User.find(params[:user_id])
    self.user = my_user
    
    if self.user.stripe_card_token.blank?
      user_email = self.user.email
      customer = Stripe::Customer.create(email: user_email, card: params[:token])
      
      card = customer.cards.data
      self.last4 = card[0].last4
      self.user.save
     end
     
     self.save!
    
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  
  end

  def charge_customer(amount)
    a = amount
    charge = Stripe::Charge.create(
      amount: a,
      currency: "usd",
      customer: self.user.stripe_card_token,
      description: "Charges for your order"
    )
  end
  handle_asynchronously :charge_customer

end
