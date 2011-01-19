class ApplicationController < ActionController::Base
  protect_from_forgery
  has_mobile_fu
  before_filter :ensure_domain, :set_time_zone
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

  def ensure_domain
    redirect_to 'http://conne.cc' if request.env['HTTP_HOST'] =~ /^www/
  end

  def set_time_zone
    if current_user
      Time.zone = current_user.time_zone
    else
      Time.zone = "Pacific Time (US & Canada)"
    end
  end

  def after_sign_in_path_for(resource)
    params[:return_to] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:last_path] || root_path
  end

  def after_update_path_for(resource)
    root_path
  end

  def update_last_path
    session[:last_path] = request.path
  end

  def norobots
    @norobots = true
  end

end
