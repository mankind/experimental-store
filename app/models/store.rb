class Store < ActiveRecord::Base
  has_many :users
  has_many :orders
  has_many :products, dependent: :destroy
  has_many :addresses
  
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true, numericality: true
end
