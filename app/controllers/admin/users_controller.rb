class Admin::UsersController < AdminController
  def index
    @users = User.all.order(created_at: :asc)
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
    @users = User.find(params[:id])

    if @users.update(user_params)
      redirect_to admin_users_path
      flash[:success] = 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
    redirect_to admin_users_path
    flash[:success] = 'User was successfully destroyed.'
  end

  private

  def user_params
    params.require(:users).permit(:username, :email, :organization_id)
  end
end
