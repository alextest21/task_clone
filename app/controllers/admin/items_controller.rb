class Admin::ItemsController < AdminController
  def index
    @items = Item.order(:category_id)
  end

  def new
    @items = Item.new
  end

  def edit
    @items = Item.find(params[:id])
  end

  def create
    @items = Item.new(items_params)

    if @items.save
      redirect_to admin_items_path
      flash[:success] = 'Item was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @items = Item.find(params[:id])

    if @items.update(items_params)
      redirect_to admin_items_path
      flash[:success] = 'Item was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @items = Item.find(params[:id])
    @items.destroy
    redirect_to admin_items_path
    flash[:success] = 'Item was successfully destroyed.'
  end

  private

  def items_params
    params.require(:items).permit(:name, :price, :category_id)
  end
end
