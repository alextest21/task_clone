require 'rails_helper'

RSpec.describe Admin::ItemsController, type: :controller do
  let(:admin) { FactoryGirl.create :user }

  let!(:item) { FactoryGirl.create :item }

  before do
    sign_in(admin)
  end

  describe 'GET index' do
    it 'assigns all item as @item' do
      get :index, {}
      expect(assigns(:items)).to eq([item])
    end
  end

  describe 'GET new' do
    it 'assigns a new item as @item' do
      get :new, {}
      expect(assigns(:items)).to be_a_new(Item)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested item as @item' do
      get :edit, id: item.id
      expect(assigns(:items)).to eq(item)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Item' do
        expect do
          post :create, items: { name: item.name, price: item.price, category_id: item.category_id }
        end.to change(Item, :count).by(1)
      end
      it 'assigns a newly created item as @item' do
        post :create, items: { name: item.name, price: item.price, category_id: item.category_id }
        expect(assigns(:items)).to be_a(Item)
        expect(assigns(:items)).to be_persisted
      end

      it 'redirects to the created item' do
        post :create, items: { name: item.name, price: item.price, category_id: item.category_id }
        expect(response).to redirect_to(admin_items_url)
      end
    end
    describe 'with invalid params' do
      it 'assigns a newly created but unsaved item as @item' do
        post :create, items: { name: nil }
        expect(assigns(:items)).to be_a_new(Item)
      end
      it "re-renders the 'new' template" do
        post :create, items: { name: nil }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'New item' } }

      it 'updates the requested item' do
        put :update, id: item.id, items: { name: new_attributes }
        item.reload
        expect(item.name) == 'New category'
      end

      it 'assigns the requested item as @item' do
        put :update, id: item.id, items: { name: item.name }
        expect(assigns(:items)).to eq(item)
      end

      it 'redirects to the item' do
        put :update, id: item.id, items: { name: item.name }
        expect(response).to redirect_to(admin_items_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns the item as @item' do
        put :update, id: item.to_param, items: { name: nil }
        expect(assigns(:items)).to eq(item)
      end

      it "re-renders the 'edit' template" do
        put :update, id: item.to_param, items: { name: nil }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroying a item' do
      expect do
        delete :destroy, id: item.id
      end.to change(Item, :count).by(-1)
    end
    it 'redirects to the items list' do
      delete :destroy, id: item.id
      expect(response).to redirect_to(admin_items_url)
    end
  end
end
