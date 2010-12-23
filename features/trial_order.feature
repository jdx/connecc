Feature: Trial pack ordering
    As a new user
    In order to get an idea of what conne.cc is all about
    I want to be able to order trial packs

    Scenario: Order place
        Given I am a new, authenticated user
            And I am on the dashboard
        When I follow "Order trial pack"
            And I press "Order trial pack"
        Then I should see "Expect your trial pack soon!"

    Scenario: Duplicate order
        Given I have placed a trial order
            And I am on the dashboard
        Then I should not see "Order trial pack"
