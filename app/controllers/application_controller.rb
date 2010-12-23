class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def after_sign_in_path_for(user)
    if current_user.admin
      admin_path
    else
      dashboard_path
    end
  end

end
