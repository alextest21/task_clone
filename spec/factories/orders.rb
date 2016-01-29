FactoryGirl.define do
  factory :order do
    user

    after(:build) do |user|
      weekday_items = create(:week_day).items
      user.items << weekday_items[0..2]
    end
  end
end
