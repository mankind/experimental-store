class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :store_id, :user_id
end
