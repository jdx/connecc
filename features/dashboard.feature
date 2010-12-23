Feature: Dashboard
    In order to use the application
    As a user
    I want to be able to access my dashboard after I login

    Scenario: User login
        Given I have a user "joe@stainlessworld.com" with password "password"
            And I go to the login page
        When I fill in "user_email" with "joe@stainlessworld.com"
            And I fill in "user_password" with "password"
            And I press "Log in"
        Then I should be on the dashboard

    Scenario: Admin login
        Given I have an admin user "admin@conne.cc" with password "secretpass"
            And I go to the login page
        When I fill in "user_email" with "admin@conne.cc"
            And I fill in "user_password" with "secretpass"
            And I press "Log in"
        Then I should be on the admin dashboard

    Scenario: Logged out user tries to access the dashboard
        Given I am not authenticated
        When I go to the dashboard
        Then I should not be on the dashboard

    Scenario: Regular user tries to access admin dashboard
        Given I am a new, authenticated user
        When I go to the admin dashboard
        Then I should not be on the admin dashboard
