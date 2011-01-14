class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated Profile"
      redirect_to profile_path
    else
      render :show
    end
  end
end
