Given /^The user "([^\"]*)" has placed a trial order$/ do |email|
  user = User.find_by_email email
  TrialOrder.create! :user => user, :address => "123 Example ST", :city => "Corvallis", :state => "OR", :zip => "97333"
end

Given /^A user has placed a trial order$/ do
  email = 'joeblow@man.net'
  password = 'secretpass'
  Given %{I have a user "#{email}" with password "#{password}"}
  And %{The user "#{email}" has placed a trial order}
end

Given /^I have placed a trial order$/ do
  email = 'joeblow@man.net'
  password = 'secretpass'

  Given %{I have a user "#{email}" with password "#{password}"}
  And %{I go to the login page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Log in"}
  And %{The user "#{email}" has placed a trial order}
end

Given /^A trial order has been generated/ do
  email = 'joeblow@man.net'
  password = 'secretpass'
  Given %{I have a user "#{email}" with password "#{password}"}
  And %{The user "#{email}" has placed a trial order}
  user = User.find_by_email email
  user.trial_order.generate_cards
end
