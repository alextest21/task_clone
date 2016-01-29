class Item < ActiveRecord::Base
  belongs_to :category

  has_many :week_items
  has_many :week_days, through: :week_items

  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :price, :category, presence: true

  def name_price
    "#{name}, #{price}"
  end
end
