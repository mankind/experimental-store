class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

=begin

  def self.create_customer_in_stripe(params)
    #if valid?
      #if !self.stripe__card_token.empty?
        #my_user = User.find(params[:user_id])
        my_user = User.find(params[:user_id])
        self.user_id = my_user
        user_email = my_user.email
        customer = Stripe::Customer.create(email: user_email, card: params[:stripeToken])
        user.stripe_card_token = customer.id
        user.last4  = customer.active_card.last4
        user.card_type = customer.active_card.type
        user.save
      #end
      self.order_id = params[order_id]
      self.save!
    #end
  end
  
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
