Given /^I am visiting Joe's connecc card$/ do
  email = 'joeblow@man.net'
  password = 'secretpass'
  Given %{I have a user "#{email}" with password "#{password}"}
  And %{The user "#{email}" has placed a trial order}
  user = User.find_by_email email
  order = user.trial_order
  order.generate_cards
  card = order.cards.first
  And %{I am on card "#{card.code}"}
end
