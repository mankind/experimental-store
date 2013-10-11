class Ability
  include CanCan::Ability
  
  def initialize(user)
    #ensures user object is not nil when no user object is passed in
    user ||= User.new    
   
    can :manage, User, :id => user.id

    can :manage, Product do | product |
      
       product.try(:user_id) == user.id   &&
     
       product.try(:user).try(:seller) == true 
    end
   
  end
end