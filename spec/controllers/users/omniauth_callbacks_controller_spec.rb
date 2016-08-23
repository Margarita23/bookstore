require 'rails_helper'

describe Users::OmniauthCallbacksController do
  include Devise::TestHelpers

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth::AuthHash.new({"provider"=>"facebook", "uid"=>"123545", "info"=>{"email" => "example_facebook@xyze.it", "name" => "Alberto Pellizzon", "first_name"=>"Alberto", "last_name" => "Pellizzon", "image" => "..." }})
  end

  it 'should authenticate and identify user if user is known' do
    get :facebook
    expect(response).to be_redirect
  end
  
  it 'user is not persisted' do
    allow_any_instance_of(User).to receive(:persisted?) {false}
    get :facebook
    expect(response). to redirect_to new_user_registration_url
  end
  
  it '#failure' do
    allow_any_instance_of(User).to receive(:persisted?) {false}
    get :facebook
    expect(response). to redirect_to new_user_registration_url
  end
end
