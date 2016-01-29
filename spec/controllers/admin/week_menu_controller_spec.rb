require 'rails_helper'

RSpec.describe Admin::WeekMenuController, type: :controller do
  let(:admin) { FactoryGirl.create(:user) }
  let(:weekday) { FactoryGirl.create(:week_day) }
  let(:items) { [weekday.items[0].id, weekday.items[1].id, weekday.items[2].id] }

  before do
    sign_in(admin)
  end

  describe 'GET index' do
    it 'assigns all weekday as @weekdays' do
      get :index, {}
      expect(assigns(:weekdays)).to eq([weekday])
    end
  end

  describe 'GET new' do
    it 'assigns a new weekday as @weekdays' do
      get :new, {}
      expect(assigns(:weekdays)).to be_a_new(WeekDay)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested weekday as @weekdays' do
      get :edit, id: weekday.id
      expect(assigns(:weekdays)).to eq(weekday)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Weekday' do
        expect do
          post :create, weekdays: { name: weekday.name, item_ids: items }
        end.to change(WeekDay, :count).by(1)
      end
      it 'assigns a newly created weekday as @weekdays' do
        post :create, weekdays: { name: weekday.name, item_ids: items }
        expect(assigns(:weekdays)).to be_a(WeekDay)
      end
    end
    describe 'with invalid params' do
      it 'assigns a newly created but unsaved weekday as @weekdays' do
        post :create, weekday: { name: nil }
        expect(assigns(:weekday)) == be_a_new(WeekDay)
      end
      it "re-renders the 'new' template" do
        post :create, weekday: { name: nil }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'New weekday' } }

      it 'updates the requested weekday' do
        put :update, id: weekday.id, weekday: { name: new_attributes }
        weekday.reload
        expect(weekday.name) == 'New weekday'
      end

      it 'assigns the requested weekday as @weekdays' do
        put :update, id: weekday.id, weekday: { name: weekday.name }
        expect(assigns(:weekday)) == eq(weekday)
      end

      it 'redirects to the weekday' do
        put :update, id: weekday.id, weekday: { name: weekday.name }
        expect(response).to redirect_to(admin_week_menu_index_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns the weekday as @weekdays' do
        put :update, id: weekday.to_param, weekdays: { name: nil }
        expect(assigns(:weekdays)).to eq(weekday)
      end

      it "re-renders the 'edit' template" do
        put :update, id: weekday.to_param, weekdays: { name: nil }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:weekday) { FactoryGirl.create(:week_day) }

    it 'destroying a weekday' do
      expect do
        delete :destroy, id: weekday.id
      end.to change(WeekDay, :count).by(-1)
    end
    it 'redirects to the weekdays list' do
      delete :destroy, id: weekday.id
      expect(response).to redirect_to(admin_week_menu_index_url)
    end
  end
end
