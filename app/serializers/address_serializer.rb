class AddressSerializer < ActiveModel::Serializer
  attributes :id, :line1, :line2string, :city, :state, :zip, :user_id
end
