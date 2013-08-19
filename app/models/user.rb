class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,  :registerable,
  devise :database_authenticatable, :recoverable, :registerable,
           :rememberable, :trackable, :validatable
  
  has_many :orders
  
  #convert the items in current cart added by a guest to  a user after the guest signs up
  def move_guest_cart_to_user(user)
    orders.update_all(user_id: user.id)
  end
  
end