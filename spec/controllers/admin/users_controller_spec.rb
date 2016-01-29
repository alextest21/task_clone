require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before do
    sign_in(user)
  end

  describe 'GET index' do
    it 'assigns all users as @users' do
      get :index, {}
      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'GET edit' do
    it 'assigns the requested users as @users' do
      get :edit, id: user.id
      expect(assigns(:users)).to eq(user)
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'New user' } }

      it 'updates the requested user' do
        put :update, id: user.id, users: { name: new_attributes }
        user.reload
        expect(user.username) == 'New user'
      end

      it 'assigns the requested user as @users' do
        put :update, id: user.id, users: { name: user.username }
        expect(assigns(:users)).to eq(user)
      end

      it 'redirects to the user' do
        put :update, id: user.id, users: { name: user.username }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns the user as @users' do
        put :update, id: user.to_param, users: { username: nil }
        expect(assigns(:users)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        put :update, id: user.to_param, users: { username: nil }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroying a user' do
      expect do
        delete :destroy, id: user.id
      end.to change(User, :count).by(-1)
    end
    it 'redirects to the users list' do
      delete :destroy, id: user.id
      expect(response).to redirect_to(admin_users_url)
    end
  end
end
