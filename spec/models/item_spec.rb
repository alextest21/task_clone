require 'rails_helper'

RSpec.describe Item, type: :model do
  before { @item = FactoryGirl.build(:item) }

  subject { @item }

  it { should respond_to(:name) }
  it { should respond_to(:price) }
  it { should respond_to(:category_id) }
  it { should be_valid }

  describe 'when name is not present' do
    before { @item.name = ' ' }
    it { should_not be_valid }
  end

  describe 'when price is not present' do
    before { @item.price = ' ' }
    it { should_not be_valid }
  end

  describe 'when category is not present' do
    before { @item.category_id = ' ' }
    it { should_not be_valid }
  end
end
