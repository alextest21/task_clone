require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  describe 'GET index' do
    let(:key) { FactoryGirl.create(:api_key) }

    it 'returns a successful 200 response' do
      get :index, access_token: key.access_token, format: 'json'
      expect(response).to be_success
    end

    it 'access denied' do
      get :index, format: 'json'
      expect(response.body).to eq('Access denied.')
    end
  end
end
