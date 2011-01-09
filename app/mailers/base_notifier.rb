class BaseNotifier < ActionMailer::Base
  layout "email"
  default :from => "no-reply@conne.cc"
end
