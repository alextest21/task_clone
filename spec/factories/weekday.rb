FactoryGirl.define do
  factory :week_day do
    name { DateTime.now.to_date.strftime('%A') }
    items do
      create_list(:item, 1, category: create(:category)) + create_list(:item, 1, category: create(:category)) + create_list(:item, 1, category: create(:category))
    end
  end
end
