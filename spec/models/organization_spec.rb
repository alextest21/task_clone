require 'rails_helper'

RSpec.describe Organization, type: :model do
  before { @organization = FactoryGirl.build(:organization) }

  subject { @organization }

  it { should respond_to(:name) }
  it { should be_valid }

  describe 'when name is not present' do
    before { @organization.name = ' ' }
    it { should_not be_valid }
  end
end
