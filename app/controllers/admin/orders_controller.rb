class Admin::OrdersController < AdminController
  def index
    @orders = Order.find_orders(params[:date])
    @date = Order.date_orders(params[:date])
    @total = Order.total_orders(@orders)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to admin_orders_path
    flash[:success] = 'Order was successfully destroyed.'
  end
end
