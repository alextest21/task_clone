require 'rails_helper'

describe 'User', type: :feature do
  let!(:admin) { FactoryGirl.create(:user) }
  let!(:user) { FactoryGirl.create(:user) }

  feature 'Sign in' do
    before { visit '/sign_in' }

    scenario 'with valid information' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'

      expect(page).to have_content 'successfully'
      expect(current_path).to eql('/')

      expect(page).to have_content(user.username)
      expect(page).to have_link('Logout')
    end

    scenario 'with invalid information' do
      click_button 'Sign in'

      expect(page).to have_selector 'div.alert.alert-warning'
      expect(current_path).to eql('/users/sign_in')
    end
  end

  feature 'Sign up' do
    before { visit '/sign_up' }

    let(:submit) { 'Sign up' }

    scenario 'with valid information' do
      fill_in 'Username', with: 'Example User'
      fill_in 'Email', with: 'user@example.com'
      select user.organization.name, from: 'user[organization_id]'
      fill_in 'Password', with: 'foobar'
      fill_in 'Password confirmation', with: 'foobar'

      expect { click_button submit }.to change(User, :count).by(1)

      expect(page).to have_selector 'div.alert.alert-info', 'Welcome'
      expect(current_path).to eql('/')
    end

    scenario 'with invalid information' do
      expect { click_button submit }.not_to change(User, :count)

      expect(page).to have_content('error')
      expect(current_path).to eql('/users')
    end
  end

  feature 'Access' do
    scenario 'as user' do
      login_as(user)
      visit '/'
      expect(page).to_not have_link('Administrator Panel')
    end

    scenario 'as admin' do
      login_as(admin)
      visit '/'
      expect(page).to have_link('Administrator Panel')
    end

    scenario 'when logout' do
      login_as(user)
      visit '/'
      click_link 'Logout'

      expect(page).to have_content('Signed out successfully.')
      expect(current_path).to eql('/')
    end
  end

  feature 'Edit page' do
    before do
      login_as(user)
      visit '/users/edit'
    end

    it { expect(page).to have_content('Edit') }
    it { expect(page).to have_link('Back') }

    scenario 'update with valid information' do
      fill_in 'Current password', with: user.password
      click_button 'Update'

      expect(page).to have_content('updated')
      expect(current_path).to eql('/')
    end

    scenario 'update with invalid information' do
      click_button 'Update'

      expect(page).to have_content 'errors'
      expect(current_path).to eql('/users')
    end
  end

  feature 'Profile' do
    before do
      login_as(user)
      visit '/profile'
    end

    scenario 'check information' do
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.organization.name)
    end
  end

  feature 'Home page' do
    before do
      login_as(user)
      visit '/'
    end

    scenario 'shows the correct navigation links' do
      within('.navbar') do
        expect(page).to have_link('Profile')
        expect(page).to have_link('Edit Profile')
        expect(page).to have_link('Logout')
        expect(page).to have_content(user.username)
        expect(page).to_not have_link('Sign in')
        expect(page).to_not have_link('Sign up')
      end
    end
  end
end
