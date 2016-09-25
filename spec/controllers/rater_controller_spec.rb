require 'rails_helper'
RSpec.describe RaterController, type: :controller do
  describe 'POST#create' do
    let(:user) { create :user }
    let(:rating) { create :rating }

    before do
      request.env['HTTP_REFERER'] = 'back'
    end

    it 'render json false' do
      allow(controller).to receive(:user_signed_in?) { false }
      post :create
      expect(response.body).to eq false.to_json
    end

    it 'render json true' do
      allow(controller).to receive(:user_signed_in?) { true }
      allow(controller).to receive(:current_user) { user }
      post :create, klass: 'Rating', id: rating.id, score: '5'
      expect(response.body).to eq true.to_json
    end
  end
end
