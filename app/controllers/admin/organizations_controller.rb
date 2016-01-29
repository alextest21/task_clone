class Admin::OrganizationsController < AdminController
  def index
    @organization = Organization.order(created_at: :asc)
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to admin_organizations_path
      flash[:success] = 'Organization was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      redirect_to admin_organizations_path
      flash[:success] = 'Organization was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to admin_organizations_path
    flash[:success] = 'Organization was successfully destroyed.'
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
