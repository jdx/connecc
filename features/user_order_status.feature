Feature: Order status
    As a user
    In order to find information on past orders
    I want to be able to see informaiton on my previous orders

    Scenario: Dashboard - orders placed
        Given I have placed a trial order
            And I am on the dashboard
        Then I should see "Order history"

    Scenario: Dashboard - no orders placed
        Given I am a new, authenticated user
            And I am on the dashboard
        Then I should not see "Order history"

    Scenario: Check order history
        Given I have placed a trial order
            And I am on the order history page
            And I follow "trial"
        Then I should see "Order details"
