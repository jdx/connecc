class BaseNotifier < ActionMailer::Base
  layout "email"
  default :from => "no-reply@conne.cc"

  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::TextHelper
  end
end
