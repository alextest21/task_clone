class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, only: [:menu]

  def home
  end

  def menu
    @date = Date.today.at_beginning_of_week
  end

  def profile
  end
end
