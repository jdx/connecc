Feature: Contact requests
    As a visitor
    In order to have the giver get back to me
    I want a quick way to have them come back and contact me

    Scenario: Fill out notification form
        Given I am visiting Joe's connecc card
        When I fill in "notification_request_email" with "chris@bobjoe.com"
            And I press "Notify me"
        Then I should see "We'll let you know"

