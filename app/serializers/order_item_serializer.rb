class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :order_id, :quantity
end
