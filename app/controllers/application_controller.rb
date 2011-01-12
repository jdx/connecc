class ApplicationController < ActionController::Base
  protect_from_forgery
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
    if params[:return_to]
      params[:return_to]
    else
      root_path
    end
  end

end
