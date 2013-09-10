class Ability
  include CanCan::Ability
  
  def initialize(user)
    #to ensure user object is not nil when no user object is passed in
    user ||= User.new    
   
    can :manage, User, :id => user.id

    #can :manage, User do |user|
        #this exposes the destroy and edit links for all users including users not yet signed_in 
       #user.id == user.id
        
        #this hid the destroy and edit links for all users including signed_in user
        #user == user 
      #user.id == :user_id
     #end
    
    can :manage, Product do | product |
      #both versions are working
       product.try(:user_id) == user.id   &&
       #product.user == user
       product.try(:user).try(:seller) == true 
    end
   
  end
end