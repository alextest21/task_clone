require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  let(:admin) { FactoryGirl.create :user }

  before do
    sign_in(admin)
    @order = FactoryGirl.create(:order)
  end

  describe 'GET show' do
    it 'assigns the requested order as @order' do
      get :show, id: @order.to_param
      expect(assigns(:order)) == eq(@order)
    end
  end

  describe 'DELETE destroy' do
    it 'destroying a order' do
      expect do
        delete :destroy, id: @order.id
      end.to change(Order, :count).by(-1)
    end
    it 'redirects to the orders list' do
      delete :destroy, id: @order.to_param
      expect(response).to redirect_to(admin_orders_url)
    end
  end
end
