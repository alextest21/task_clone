class WeekItem < ActiveRecord::Base
  belongs_to :week_day
  belongs_to :item
end
