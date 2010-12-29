class Admin::AdminController < ApplicationController
  before_filter :admin_required

  def dashboard
  end

  private

  def admin_required
    if !current_user or !current_user.admin
      flash[:alert] = "You do not have permission to view that page"
      redirect_to root_path
    end
  end
end
