require 'rails_helper'

RSpec.describe Admin::OrganizationsController, type: :controller do
  let(:admin) { FactoryGirl.create :user }

  let!(:organization) { FactoryGirl.create :organization }

  before do
    sign_in(admin)
  end

  describe 'GET index' do
    it 'assigns all organization as @organization' do
      get :index, {}
      expect(assigns(:organization)) == eq([organization])
    end
  end

  describe 'GET new' do
    it 'assigns a new organization as @organization' do
      get :new, {}
      expect(assigns(:organization)).to be_a_new(Organization)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested organization as @organization' do
      get :edit, id: organization.id
      expect(assigns(:organization)).to eq(organization)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Organization' do
        expect do
          post :create, organization: { name: organization.name }
        end.to change(Organization, :count).by(1)
      end
      it 'assigns a newly created organization as @organization' do
        post :create, organization: { name: organization.name }
        expect(assigns(:organization)).to be_a(Organization)
        expect(assigns(:organization)).to be_persisted
      end

      it 'redirects to the created organization' do
        post :create, organization: { name: organization.name }
        expect(response).to redirect_to(admin_organizations_url)
      end
    end
    describe 'with invalid params' do
      it 'assigns a newly created but unsaved organization as @organization' do
        post :create, organization: { name: nil }
        expect(assigns(:organization)).to be_a_new(Organization)
      end
      it "re-renders the 'new' template" do
        post :create, organization: { name: nil }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'New organization' } }

      it 'updates the requested organization' do
        put :update, id: organization.id, organization: { name: new_attributes }
        organization.reload
        expect(organization.name) == 'New organization'
      end

      it 'assigns the requested organization as @organization' do
        put :update, id: organization.id, organization: { name: organization.name }
        expect(assigns(:organization)).to eq(organization)
      end

      it 'redirects to the organization' do
        put :update, id: organization.id, organization: { name: organization.name }
        expect(response).to redirect_to(admin_organizations_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns the organization as @organization' do
        put :update, id: organization.to_param, organization: { name: nil }
        expect(assigns(:organization)).to eq(organization)
      end

      it "re-renders the 'edit' template" do
        put :update, id: organization.to_param, organization: { name: nil }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroying a organization' do
      expect do
        delete :destroy, id: organization.id
      end.to change(Organization, :count).by(-1)
    end
    it 'redirects to the organizations list' do
      delete :destroy, id: organization.id
      expect(response).to redirect_to(admin_organizations_url)
    end
  end
end
