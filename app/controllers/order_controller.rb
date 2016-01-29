class OrderController < ApplicationController
  before_filter :authenticate_user!

  def index
    @weekday = params[:weekday].to_date.strftime('%A') if params[:weekday]
    @daymenu = WeekDay.find_by_name(@weekday)
    @date = params[:weekday]
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new
    @order.items << Item.where(id: params[:item_ids])

    if @order.save
      redirect_to order_information_path(order_id: @order.id)
      flash[:success] = 'Your order is placed successfully.'
    else
      render 'new'
    end
  end

  def information
    @order = current_user.orders.find_by_id(params[:order_id])
  end
end
