class AdminController < ApplicationController
  layout 'admin/admin'

  before_action :require_admin

  def index
  end

  protected

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
