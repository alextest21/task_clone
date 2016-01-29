require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin) { FactoryGirl.create :user }

  let!(:category) { FactoryGirl.create :category }

  before do
    sign_in(admin)
  end

  describe 'GET index' do
    it 'assigns all category as @category' do
      get :index, {}
      expect(assigns(:category)).to eq([category])
      expect(response).to be_success
    end
  end

  describe 'GET new' do
    it 'assigns a new category as @category' do
      get :new, {}
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested category as @category' do
      get :edit, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Category' do
        expect do
          post :create, category: { name: category.name }
        end.to change(Category, :count).by(1)
      end
      it 'assigns a newly created category as @category' do
        post :create, category: { name: category.name }
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the created category' do
        post :create, category: { name: category.name }
        expect(response).to redirect_to(admin_categories_url)
      end
    end
    describe 'with invalid params' do
      it 'assigns a newly created but unsaved category as @category' do
        post :create, category: { name: nil }
        expect(assigns(:category)).to be_a_new(Category)
      end
      it "re-renders the 'new' template" do
        post :create, category: { name: nil }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'New category' } }

      it 'updates the requested category' do
        put :update, id: category.id, category: { name: new_attributes }
        category.reload
        expect(category.name) == 'New category'
      end

      it 'assigns the requested category as @category' do
        put :update, id: category.id, category: { name: category.name }
        expect(assigns(:category)).to eq(category)
      end

      it 'redirects to the category' do
        put :update, id: category.id, category: { name: category.name }
        expect(response).to redirect_to(admin_categories_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns the category as @category' do
        put :update, id: category.to_param, category: { name: nil }
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        put :update, id: category.to_param, category: { name: nil }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroying a category' do
      expect do
        delete :destroy, id: category.id
      end.to change(Category, :count).by(-1)
    end
    it 'redirects to the categories list' do
      delete :destroy, id: category.id
      expect(response).to redirect_to(admin_categories_url)
    end
  end
end
