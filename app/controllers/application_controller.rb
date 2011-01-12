class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :update_last_path
  layout "narrow"

  protected

  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::TextHelper
  end

  def after_sign_in_path_for(resource)
    params[:return_to] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:last_path] || root_path
  end

  def update_last_path
    session[:last_path] = request.path
  end

end
