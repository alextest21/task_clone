class Order < ActiveRecord::Base
  validate :validate_items

  before_create :total_price

  belongs_to :user
  delegate :username, :to => :user, :prefix => true

  has_many :order_items
  has_many :items, through: :order_items, dependent: :destroy

  def total_price
    self.total = items.map(&:price).sum
  end

  def validate_items
    unless items.map(&:category_id).uniq.length == items.map(&:category_id).length && items.size == 3
      errors.add :items, 'Please select one item from each category'
    end
  end

  def self.getOrders
    date = Date.today
    @orders = Order.where(created_at: date..date.end_of_day)
    @orders.to_json
  end

  def self.find_orders(date_params)
    if date_params
      date = date_params.to_date
    else
      date = Date.today
    end
    Order.where(created_at: date..date.end_of_day).order(id: :desc) if date.present?
  end

  def self.date_orders(date_params)
    if date_params
      date = date_params.to_date
    else
      date = Date.today
    end
  end

  def self.total_orders(orders)
    orders.map(&:total).sum if orders.present?
  end
end
