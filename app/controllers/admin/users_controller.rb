class Admin::UsersController < Admin::ApplicationController
  def index
    @users = ::User.order(:created_at => :desc).page(params[:page])
  end
  
  def destroy
    user = ::User.find(params[:id])
    user.destroy
    
    flash[:notice] = "User was succesfully deleted."
    redirect_to admin_users_path
  end
end
