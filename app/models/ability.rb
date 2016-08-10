class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
      alias_action :create, :update, :destroy, :to => :cud
      cannot :cud, [Cart, Checkout]
      cannot :create, Order
      cannot :create, Rating
    elsif !user.new_record?
      can :read, [Book, Category, Author, Rating, Cart, LineItem, Address, Order]
      alias_action :create, :read, :update, :destroy, :to => :crud
      can :crud, [Cart, Address] 
      alias_action :create, :read, :destroy, :to => :cred
      can :cred, LineItem
      can :update_items, Cart
      can :create, [Rating, Order]
      can :new_order, Order
      can :read, [Book, Category, Author, Rating]
    else
      can :read, [Book, Category, Author, Rating]
      cannot :create, Rating
    end
  end
end
