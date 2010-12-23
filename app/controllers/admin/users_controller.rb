class Admin::UsersController < Admin::AdminController

  def index
  end

  def show
    @user = User.find(params[:id])
  end

end
