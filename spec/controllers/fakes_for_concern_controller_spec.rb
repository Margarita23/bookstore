require 'rails_helper'
class FakesForConcernController < ApplicationController
  include CurrentCart
end

describe FakesForConcernController do
  let(:user) { create :user }
  let(:user_2) { create :user }
  let(:cart) { create :cart, user_id: user.id }

  it 'should return cart' do
    allow(controller).to receive(:current_user) { user }
    allow_any_instance_of(User).to receive(:cart) { cart }
    subject.set_cart
    expect(assigns(:cart)).to eq cart
  end

  it 'should return new cart' do
    allow(controller).to receive(:current_user) { user_2 }
    subject.set_cart
    expect(assigns(:cart).id).to eq user_2.id
  end
end
