Given /^I have placed a trial order$/ do
  email = 'bob@man.net'
  password = 'secretpass'

  Given %{I have a user "#{email}" with password "#{password}"}
  And %{I go to the login page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Log in"}

  user = User.find_by_email email
  user.orders << Order.new(:placed_at => DateTime.now, :trial => true)
  user.save
end
