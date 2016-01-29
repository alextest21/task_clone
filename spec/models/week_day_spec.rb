require 'rails_helper'

RSpec.describe WeekDay, type: :model do
  before { @weekday = FactoryGirl.build(:week_day) }

  subject { @weekday }

  it { should respond_to(:name) }
  it { should be_valid }

  describe 'when name is not present' do
    before { @weekday.name = ' ' }
    it { should_not be_valid }
  end

  describe 'when name is already taken' do
    before(:each) do
      @weekday_with_same_name = @weekday.dup
      @weekday_with_same_name.name = @weekday.name
    end
    it { expect(@weekday_with_same_name).not_to be_valid }
  end
end
