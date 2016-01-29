class Admin::WeekMenuController < AdminController
  def index
    @weekdays = WeekDay.all
  end

  def show
    @weekdays = WeekDay.find(params[:id])
    @weekdays.items.joins(:category)
  end

  def new
    @weekdays = WeekDay.new
  end

  def edit
    @weekdays = WeekDay.find(params[:id])
  end

  def create
    @weekdays = WeekDay.new(weekday_params)

    if @weekdays.save
      redirect_to admin_week_menu_index_path
      flash[:success] = 'Day menu was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @weekdays = WeekDay.find(params[:id])

    if @weekdays.update(weekday_params)
      redirect_to admin_week_menu_index_path
      flash[:success] = 'Day menu was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @weekdays = WeekDay.find(params[:id])
    @weekdays.destroy
    redirect_to admin_week_menu_index_path
    flash[:success] = 'Day menu was successfully destroyed.'
  end

  private

  def weekday_params
    params.fetch(:weekdays, {}).permit(:name).tap do |whitelisted|
      whitelisted[:item_ids] = params[:items][:item_ids] unless params[:items].nil?
    end
  end
end
