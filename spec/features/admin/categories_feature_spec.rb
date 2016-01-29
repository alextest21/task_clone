require 'rails_helper'

feature 'Categories' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:category) { FactoryGirl.create(:category) }

  feature 'Categories index page' do
    before do
      login_as(admin)
      visit '/admin/categories'
    end

    it { expect(page).to have_content('Categories') }
    it { expect(page).to have_link('Add Category') }
    it { expect(page).to have_content(category.name) }

    scenario 'delete category' do
      expect { click_link('', href: admin_category_path(category)) }.to change(Category, :count).by(-1)

      expect(page).to have_content 'destroyed'
      expect(current_path).to eql('/admin/categories')
    end
  end

  feature 'Categories new page' do
    before do
      login_as(admin)
      visit '/admin/categories/new'
    end

    it { expect(page).to have_content('Add Category') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      fill_in 'Name', with: category.name

      click_button 'Save'

      expect(page).to have_content 'created'
      expect(current_path).to eql('/admin/categories')
    end

    scenario 'with invalid information' do
      click_button 'Save'

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql('/admin/categories')
    end
  end

  feature 'Categories edit page' do
    before do
      login_as(admin)
      visit edit_admin_category_path(category)
    end

    it { expect(page).to have_content('Edit Category') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      click_button 'Save'

      expect(page).to have_content('updated')
      expect(current_path).to eql('/admin/categories')
    end

    scenario 'with invalid information' do
      fill_in 'Name', with: ' '
      click_button 'Save'

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql("/admin/categories/#{category.id}")
    end
  end
end
