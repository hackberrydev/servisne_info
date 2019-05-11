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
  
  def edit
    @user = ::User.find(params[:id])
  end
  
  def update
    @user = ::User.find(params[:id])
    if @user.update(:streets => params[:user][:streets])
      flash[:notice] = "User was succesfully saved."
      redirect_to admin_users_path
    else
      render :edit
    end
  end
end
