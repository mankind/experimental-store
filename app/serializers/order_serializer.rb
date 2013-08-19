class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status
end
