class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :user_id, :card_last4, :card_expiration, :card_type, :stripe_card_token
end
