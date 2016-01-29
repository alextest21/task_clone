require 'rails_helper'

feature 'Order' do
  let(:user) { FactoryGirl.create :user }
  let!(:order) { FactoryGirl.create :order }
  let(:today) { Date.today.strftime('%d.%m.%Y') }

  feature 'Menu page' do
    before do
      login_as(user)
      visit '/menu'
    end

    scenario 'check weekdays name' do
      expect(page).to have_link('Monday')
      expect(page).to have_link('Tuesday')
      expect(page).to have_link('Wednesday')
      expect(page).to have_link('Thursday')
      expect(page).to have_link('Friday')
      expect(page).to have_link('Saturday')
      expect(page).to have_link('Sunday')
    end
  end

  feature 'Order index' do
    before { login_as(user) }

    scenario 'when button is active' do
      visit '/order/?weekday=' + today

      expect(page).to have_link('Make order')
    end

    scenario 'order button is inactive' do
      day = Date.today + 1.day
      visit '/order/?weekday=' + day.strftime('%d.%m.%Y')

      expect(page).to_not have_link('Make order')
    end
  end

  feature 'Order new' do
    before do
      login_as(user)
      visit '/order/new'
    end

    it { expect(page).to have_content('New order') }

    scenario 'with valid information' do
      all('select').each do |n|
        n.find(:xpath, 'option[1]').select_option
      end
      expect { click_button 'Create Order' }.to change(Order, :count).by(1)

      expect(page).to have_content('successfully')

      expect(page).to have_content('Information')
      expect(page).to have_content(order.total)
      expect(current_path).to eql('/order/information')
    end

    scenario 'with invalid information' do
      expect { click_button 'Create Order' }.not_to change(Order, :count)

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql('/order')
    end
  end

  feature 'Order json API' do
    before { @key = FactoryGirl.create(:api_key) }

    scenario 'with valid access token' do
      visit '/api/orders/?access_token=' + @key.access_token

      expect(page).to have_content order.total
    end

    scenario 'with invalid access token' do
      visit '/api/orders/?access_token=' + 'not_valid_key'

      expect(page).to have_content('denied')
    end
  end
end
