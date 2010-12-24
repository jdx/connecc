Feature: User registration
    In order to use the site
    As a user
    I want to be able to register

    Scenario: Visitor signup
        Given I am on the signup page
        When I fill in "user_first_name" with "Bob"
            And I fill in "user_last_name" with "Jones"
            And I fill in "user_address_1" with "123 Example ST"
            And I fill in "user_city" with "Corvallis"
            And I fill in "user_state" with "OR"
            And I fill in "user_zip_code" with "97333"
            And I fill in "user_email" with "test@example.com"
            And I fill in "user_password" with "password"
            And I fill in "user_password_confirmation" with "password"
            And I press "Sign up"
        Then I should be on the dashboard
