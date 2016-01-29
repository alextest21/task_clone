class WeekDay < ActiveRecord::Base
  has_many :week_items
  has_many :items, through: :week_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates_presence_of :items

  def self.find_items(category)
    date = DateTime.now.to_date.strftime('%A')
    find_by_name(date).items.where(category: category)
  end
end
