class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new    #to ensure user object is not nil when no user object is passed in
   
      can :manage, User do |user|
        user.user_id = user.id
      end
    
      
   
  end
end