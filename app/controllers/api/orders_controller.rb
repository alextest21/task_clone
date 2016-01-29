class Api::OrdersController < ApplicationController
  before_filter :restrict_access

  def index
    render layout: false, json: Order.getOrders
  end

  private

  def restrict_access
    api_key = ApiKey.find_by_access_token(params[:access_token])
    render html: 'Access denied.', status: :unauthorized unless api_key
  end
end
