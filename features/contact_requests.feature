Feature: Contact requests
    As a visitor
    In order to know when a giver posts a message
    I want to be notified when the giver posts a message

    Scenario: Fill out contact request
        Given I am visiting Joe's connecc card
            And Joe has posted a message
        When I fill in "contact_request_contact_info" with "chris@bobjoe.com"
            And I fill in "contact_request_message" with "I like it! Get back to me when you get a chance!"
            And I press "Get back to me"
        Then I should see "will be getting a hold of you"
            And Joe should receive an email
