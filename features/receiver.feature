Feature: Connecting with giver
    As a receiver
    In order to get in touch with the giver
    I want to be able to visit a card url to get information about a user

    Scenario: Get giver's name
        Given I am visiting Joe's connecc card
        Then I should see "Joe Blow"
