class AdminUserController < ApplicationController
  layout 'admin'

  # before_action( :confirm_logged_in)

  def index
    @admin_user = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)

    if @admin_user.save
      flash[:notice] = "Admin user #{admin_user.email} created successfully."
      redirect_to(action: 'index')
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])

    if @admin_user.update(admin_user_params)
      flash[:notice] = "Admin user #{admin_user.email} updated successfully."
      redirect_to(action: 'index')
    else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin user #{admin_user.email} deleted successfully."
    redirect_to(action: 'index')
  end

  private
  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
  end
end
