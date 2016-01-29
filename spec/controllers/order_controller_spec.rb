require 'rails_helper'

RSpec.describe OrderController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  let(:order) { FactoryGirl.create(:order) }

  describe 'POST create' do
    before do
      sign_in(@user)
    end

    describe 'with valid params' do
      it 'creates a new order' do
        expect do
          post :create, order: order, format: :html
        end.to change(Order, :count).by(1)
      end

      it 'assigns a newly created order as @order' do
        post :create, order: order, format: :html
        expect(assigns(:order)).to be_a(Order)
      end
    end
  end
end
