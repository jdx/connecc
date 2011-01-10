class Admin::UsersController < Admin::AdminController

  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find(params[:id])
  end

end
