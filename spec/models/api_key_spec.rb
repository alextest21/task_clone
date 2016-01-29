require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  let(:key) { FactoryGirl.build(:api_key) }

  it { expect(key).to respond_to(:access_token) }
  it { expect(key).to callback(:generate_access_token).before(:create) }
end
