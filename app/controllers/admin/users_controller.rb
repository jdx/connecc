class Admin::UsersController < Admin::AdminController

  def index
    @users = User.order(:id)
    @total_users = User.count
  end

  def show
    @user = User.find(params[:id])
  end

end
