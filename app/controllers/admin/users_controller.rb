class Admin::UsersController < Admin::ApplicationController
  before_action :find_user, only: [:destroy, :edit, :update]

  def index
    @users = ::User.order(created_at: :desc).page(params[:page])
  end

  def destroy
    @user.destroy!

    flash[:notice] = "User was succesfully deleted."
    redirect_to admin_users_path
  end

  def edit
  end

  def update
    if @user.update(streets: params[:user][:streets])
      flash[:notice] = "User was succesfully saved."
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def find_user
    @user = ::User.find(params[:id])
  end
end
