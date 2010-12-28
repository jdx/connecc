Feature: Admin orders
    As a user
    In order receive orders
    I want the admin to fulfill orders

    Scenario: There is an order awaiting generation
        Given A user has placed a trial order
            And I am logged in as an admin
            And I am on the admin dashboard
            And I follow "Orders"
            And I follow "Order 1"
            And I press "Generate"
        Then I should see "Cards generated"

    Scenario: There is an order awaiting shipment
        Given A trial order has been generated
            And I am logged in as an admin
            And I am on the admin dashboard
            And I follow "Orders"
            And I follow "Order 1"
            And I press "Ship"
        Then I should see "Order marked as shipped"

