require 'rails_helper'

feature 'Organizations' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:organization) { FactoryGirl.create(:organization) }

  feature 'Organizations index' do
    before do
      login_as(admin)
      visit '/admin/organizations'
    end

    it { expect(page).to have_content('Organizations') }
    it { expect(page).to have_link('Add Organization') }

    scenario 'delete item' do
      expect { click_link('', href: admin_organization_path(organization)) }.to change(Organization, :count).by(-1)

      expect(page).to have_content 'destroyed'
      expect(current_path).to eql('/admin/organizations')
    end

    scenario "check button 'Add Organization'" do
      click_link 'Add Organization'
      expect(page).to have_content('Add Organization')
      expect(current_path).to eql('/admin/organizations/new')
    end
  end

  feature 'Organizations new page' do
    before do
      login_as(admin)
      visit '/admin/organizations/new'
    end

    it { expect(page).to have_content('Add Organization') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      find('#organization_name').set('organization.name')
      expect { click_button 'Save' }.to change(Organization, :count).by(1)

      expect(page).to have_content 'created'
      expect(current_path).to eql('/admin/organizations')
    end

    scenario 'with invalid information' do
      expect { click_button 'Save' }.not_to change(Organization, :count)

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql('/admin/organizations')
    end
  end

  feature 'Organizations edit page' do
    before do
      login_as(admin)
      visit edit_admin_organization_path(organization)
    end

    it { expect(page).to have_content('Edit Organization') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      click_button 'Save'

      expect(page).to have_content('updated')
      expect(current_path).to eql('/admin/organizations')
    end

    scenario 'with invalid information' do
      find('#organization_name').set('')
      click_button 'Save'

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql("/admin/organizations/#{organization.id}")
    end
  end
end
