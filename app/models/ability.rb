class Ability
  include CanCan::Ability

  def initialize(user)
    #user ||= User.new # guest user (not logged in)
    
    #if user.role == "member"
      #can :read, [Book, Category, Rating]

      #can :new, [Rating]
      #can :create, [Rating]
      #can :edit, [User], id: user.id
      #can :update, [User], id: user.id
      #can :update_password, [User], id: user.id
        
    #els
    #if user.admin
      #can :access, :rails_admin
      #can :dashboard
      #can :manage, :all
    #end
  end
end
