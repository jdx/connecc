Given /^I am not authenticated$/ do
  visit('/users/sign_out')
end

Given /^I have one user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  User.new(:email => email, :password => password, :password_confirmation => password).save!
end

Given /^I am a new, authenticated user$/ do
  email = 'bob@man.net'
  password = 'secretpass'

  Given %{I have one user "#{email}" with password "#{password}"}
  And %{I go to the login page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Log in"}
end

