require 'rails_helper'

feature 'WeekMenu' do
  let(:admin) { FactoryGirl.create(:admin, email: 'weekmenu@mail.com') }
  let!(:weekday) { FactoryGirl.create(:week_day) }

  feature 'WeekMenu index' do
    before do
      login_as(admin)
      visit '/admin/week_menu'
    end

    it { expect(page).to have_content('Menu') }
    it { expect(page).to have_link('Add day menu') }

    scenario 'delete day menu' do
      expect { find('.destroy_link').click }.to change(WeekDay, :count).by(-1)

      expect(page).to have_content 'destroyed'
      expect(current_path).to eql('/admin/week_menu')
    end
  end

  feature 'Day menu new' do
    before do
      login_as(admin)
      visit '/admin/week_menu/new'
    end

    it { expect(page).to have_content('new') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      choose 'Sunday'
      find(:xpath, "(//input[@type='checkbox'])[1]").set(true)
      expect { click_button 'Save' }.to change(WeekDay, :count).by(1)

      expect(page).to have_content 'created'
      expect(current_path).to eql('/admin/week_menu')
    end

    scenario 'with invalid information' do
      expect { click_button 'Save' }.not_to change(WeekDay, :count)

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql('/admin/week_menu')
    end
  end

  feature 'Day menu edit page' do
    before do
      login_as(admin)
      visit edit_admin_week_menu_path(weekday)
    end

    it { expect(page).to have_content('Edit day menu') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      click_button 'Save'

      expect(page).to have_content('updated')
      expect(current_path).to eql('/admin/week_menu')
    end

    scenario 'with invalid information' do
      all('input[type=checkbox]').each do |n|
        n.set(false)
      end
      click_button 'Save'

      expect(page).to have_selector('div.alert.alert-danger')
    end
  end

  feature 'Day menu show page' do
    before do
      login_as(admin)
      visit admin_week_menu_path(weekday)
    end

    it { expect(page).to have_content('show') }
  end
end
