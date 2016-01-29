require 'rails_helper'

RSpec.describe Category, type: :model do
  before { @category = FactoryGirl.build(:category) }

  subject { @category }

  it { should respond_to(:name) }
  it { should be_valid }

  describe 'when name is not present' do
    before { @category.name = ' ' }
    it { should_not be_valid }
  end
end
