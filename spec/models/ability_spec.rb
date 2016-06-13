require 'rails_helper'
require "cancan/matchers"

describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ create :user }
  
    context "when is a guest" do
      it{ should be_able_to(:read, Book, Category, Author, Rating ) }
      it{ should_not be_able_to(:read, Order, LineItem, Cart, User, Address, Checkout ) }
      
    end
    
    context "when is a member" do
      let(:user){ create :user, guest: false }

      it{ should_not be_able_to(:destroy, Book, Category, Rating, Author) }
      
    end
    
    context "when is a admin" do

    end
  end
end