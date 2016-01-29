require 'rails_helper'

feature 'Orders' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:order) { FactoryGirl.create(:order) }

  feature 'Order index' do
    before do
      login_as(admin)
      visit '/admin/orders'
    end

    it { expect(page).to have_content('Orders') }

    scenario 'filling date with invalid information' do
      fill_in 'date', with: order.items[0].created_at
      click_button 'Submit'

      expect(page).to have_content order.items[0].name
    end

    scenario 'filling date with invalid information' do
      fill_in 'date', with: ' '
      click_button 'Submit'

      expect(page).to have_content('No orders')
      expect(current_path).to eql('/admin/orders')
    end

    scenario 'when destroy order' do
      expect { find('.destroy_link').click }.to change(Order, :count).by(-1)

      expect(page).to have_content 'destroyed'
      expect(current_path).to eql('/admin/orders')
    end
  end
end
