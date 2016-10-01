# Ability.
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin
      abilities_for_admin
    elsif !user.new_record?
      abilities_for_members
    else
      can :read, [Book, Category, Author, Rating]
      cannot :create, Rating
    end
  end

  def abilities_for_admin
    can :access, :rails_admin
    can :dashboard
    can :manage, :all
  end

  def abilities_for_members
    can :read, [Book, Category, Author, Rating, Cart, LineItem, Address, Order]
    alias_action :create, :read, :update, :destroy, to: :crud
    can :crud, [Cart, Address]
    alias_action :create, :read, :update, :destroy, to: :cred
    can :cred, LineItem
    can :update_items, Cart
    can :create, [Rating, Order]
    can :new_order, Order
    can :read, [Book, Category, Author, Rating]
    can :update, Coupon
  end
end
