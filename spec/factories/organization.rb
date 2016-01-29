FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "name#{n}" }
  end
end
