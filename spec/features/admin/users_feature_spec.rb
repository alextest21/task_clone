require 'rails_helper'

feature 'Users' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user, email: 'test_user@mail.com') }

  feature 'Users index page' do
    before do
      login_as(admin)
      visit '/admin/users'
    end

    it { expect(page).to have_content('Users') }

    scenario 'delete user' do
      expect { click_link('', href: admin_user_path(user)) }.to change(User, :count).by(-1)

      expect(page).to have_content 'destroyed'
      expect(current_path).to eql('/admin/users')
    end
  end

  feature 'Users edit page' do
    before do
      login_as(admin)
      visit edit_admin_user_path(user)
    end

    it { expect(page).to have_content('Edit User') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      click_button 'Save'

      expect(page).to have_content('updated')
      expect(current_path).to eql('/admin/users')
    end

    scenario 'with invalid information' do
      fill_in 'users[username]', with: ' '
      click_button 'Save'

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql("/admin/users/#{user.id}")
    end
  end
end
