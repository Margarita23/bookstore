require 'rails_helper'
require "cancan/matchers"
describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
  
    context "when is a guest" do
      let(:user){ User.new }
      it{ should be_able_to(:read, Book, Category, Author, Rating ) }
      it{ should_not be_able_to(:read, Order, LineItem, Cart, User, Address, Checkout ) }
    end
    
    context "when is a member" do
      let(:user){ create :user }
      it{ should_not be_able_to(:destroy, Book, Category, Rating, Author) }
      it{ should_not be_able_to(:create, Book, Category, Author) }
    end
    
    context "when is a admin" do
      let(:user){ create :user, admin: true }
      it{ should be_able_to(:destroy, Book, Category, Rating, Author) }
    end
  end
end