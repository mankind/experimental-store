class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :address
  
  # look up :subject on the model, but use +user+ in the JSON
  attribute :user_id, key: :user  
 end
