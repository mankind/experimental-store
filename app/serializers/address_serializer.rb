class AddressSerializer < ActiveModel::Serializer
  attributes :id, :line1, :line2, :city, :state, :zip, :user_id
end
