Given /^I am not authenticated$/ do
  visit('/users/sign_out')
end

Given /^Joe has an account$/ do
  Given %{I have a user "joe@conne.cc" with password "password"}
end

Given /^I have a user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  user = User.new(:email => email, :password => password)
  user.first_name = "Joe"
  user.last_name = "Blow"
  user.save
end

Given /^I have an admin user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Given %{I have a user "#{email}" with password "#{password}"}
  user = User.find_by_email(email)
  user.admin = true
  user.save
end

Given /^I am logged in as user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Given %{I have a user "#{email}" with password "#{password}"}
  And %{I go to the login page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Log in"}
  @current_user = User.find_by_email(email)
end

Given /^I am a new, authenticated user$/ do
  email = 'joe@conne.cc'
  password = 'secretpass'

  Given %{I am logged in as user "#{email}" with password "#{password}"}
end

Then /^Joe should receive an email$/ do
  email = 'joe@conne.cc'
  Then %{"#{email}" should receive an email}
end

Given /^I am logged in as an admin$/ do
  email = 'jeff@conne.cc'
  password = 'secretpass'

  Given %{I have an admin user "#{email}" with password "#{password}"}
  And %{I go to the login page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Log in"}
end

Then /^(?:|I )should not be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should_not == path_to(page_name)
  else
    assert_not_equal path_to(page_name), current_path
  end
end

