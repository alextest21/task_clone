require 'rails_helper'

feature 'Items' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:category) { FactoryGirl.create(:category) }
  let!(:item) { FactoryGirl.create(:item, category_id: category.id) }

  feature 'Items index' do
    before do
      login_as(admin)
      visit '/admin/items'
    end

    it { expect(page).to have_content('Items') }
    it { expect(page).to have_link('Add Item') }

    scenario 'delete item' do
      expect { click_link('', href: admin_item_path(item)) }.to change(Item, :count).by(-1)

      expect(page).to have_content 'destroyed'
      expect(current_path).to eql('/admin/items')
    end
  end

  feature 'Items new page' do
    before do
      login_as(admin)
      visit '/admin/items/new'
    end

    it { expect(page).to have_content('Add Item') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      select category.name, from: 'items[category_id]'

      fill_in 'items[name]', with: item.name
      fill_in 'items[price]', with: item.price

      expect { click_button 'Save' }.to change(Item, :count).by(1)

      expect(page).to have_content 'created'
      expect(current_path).to eql('/admin/items')
    end

    scenario 'with invalid information' do
      expect { click_button 'Save' }.not_to change(Item, :count)

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql('/admin/items')
    end
  end

  feature 'Items edit page' do
    before do
      login_as(admin)
      visit edit_admin_item_path(item)
    end

    it { expect(page).to have_content('Edit Item') }
    it { expect(page).to have_link('Back') }

    scenario 'with valid information' do
      select category.name, from: 'items[category_id]'
      fill_in 'items[name]', with: item.name
      fill_in 'items[price]', with: item.price
      click_button 'Save'

      expect(page).to have_content('updated')
      expect(current_path).to eql('/admin/items')
    end

    scenario 'with invalid information' do
      fill_in 'items[name]', with: ' '
      click_button 'Save'

      expect(page).to have_selector('div.alert.alert-danger')
      expect(current_path).to eql("/admin/items/#{item.id}")
    end
  end
end
