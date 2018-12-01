class Admin::UsersController < Admin::ApplicationController
  def index
    @users = ::User.order(:created_at => :desc).page(params[:page])
  end
end
