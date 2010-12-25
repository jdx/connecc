Given /^I have placed a trial order$/ do
  email = 'bob@man.net'
  password = 'secretpass'

  Given %{I have a user "#{email}" with password "#{password}"}
  And %{I go to the login page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Log in"}

  user = User.find_by_email email
  TrialOrder.create! :user => user, :address => "123 Example ST", :city => "Corvallis", :state => "OR", :zip => "97333"
end
