require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:weekday) { FactoryGirl.create(:week_day, name: 'weekday_order') }
  let(:date) { Date.today }
  let(:order) { FactoryGirl.create(:order, created_at: date) }
  let(:items) { [weekday.items[0], weekday.items[1], weekday.items[2]] }

  subject { order }

  it { should respond_to(:user_id) }
  it { should respond_to(:total) }

  it { expect(order).to callback(:total_price).before(:create) }

  it { should be_valid }

  describe '#total_price' do
    it 'calculate the total price of the order' do
      order.items = items

      order.total_price
      expect(order.total).to eq(weekday.items[0].price + weekday.items[1].price + weekday.items[2].price)
    end
  end

  describe '#validate_items' do
    it 'when one item from each category is valid' do
      order.items = items

      expect(order).to be_valid
    end

    it 'when category is not unique' do
      items_category = [weekday.items[0], weekday.items[1], weekday.items[1]]
      order.items = items_category

      expect(order).to_not be_valid
    end

    it 'when items is not equal 3' do
      items = [weekday.items[0], weekday.items[1]]
      order.items = items

      expect(order).to_not be_valid
    end
  end

  describe '.getOrders' do
    scenario 'includes order' do
      orders = [{ "id": order.id, "total": order.total, "created_at": order.created_at, "updated_at": order.updated_at, "user_id": order.user_id }].to_json

      expect(Order.getOrders).to be_json_eql(orders)
    end
  end

  describe '.find_orders' do
    it { expect Order.find_orders(date) == order }
  end

  describe '.total_orders' do
    it 'when valid' do
      orders = Order.find_orders(date)
      expect(Order.total_orders(orders)) == order.total
    end
  end
end
