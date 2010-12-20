Feature: Mailing list signup
    In order to get more people involed with conne.cc
    As an admin
    I want users to sign up for the mailing list

    Scenario: Visitor signup
        Given I am on the home page
        When I fill in "email" with "testuser@test.com"
            And I press "Sign up!"
        Then I should see "Thank"
