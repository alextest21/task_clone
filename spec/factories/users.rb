FactoryGirl.define do
  factory :user do
    username 'name'
    sequence(:email) { |n| "person#{n}@example.com" }
    password '123456'
    password_confirmation '123456'
    admin false
    organization
  end
  factory :admin, class: User do
    username 'name'
    sequence(:email) { |n| "person#{n}@example.com" }
    password '123456'
    password_confirmation '123456'
    admin true
    organization
  end
end
