class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
      alias_action :create, :update, :destroy, :to => :cud
      cannot :cud, [Cart, LineItem, Checkout]
      cannot :create, Order
      can :update, Rating
      cannot :create, Rating
    elsif !user.guest
      can :read, [Book, Category, Author, Rating, Cart, LineItem, Address, Order]
      alias_action :create, :read, :update, :destroy, :to => :crud
      can :crud, [Cart, LineItem, Address] 
      can :create, [Rating, Order]
      can :new_order, Order
    else
      can :read, [Book, Category, Author, Rating]
    end
  end
end
