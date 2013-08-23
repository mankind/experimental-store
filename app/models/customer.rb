class Customer < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates  :user_id, :store_id, presence: true, numericality: true
  has_many :addresses
  has_many :orders
  belongs_to :store
  belongs_to :user
end
