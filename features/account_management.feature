Feature: Account Management
   In order to add events to my calendar
   As a user
   I want to create an account to login to the system

  Scenario: Successful account creation
   Given I am a new user to the site
   When I create an account
   Then I should be successfully signed up

 Scenario: Successful account login
   Given I have an exisiting login
   When I login
   Then I should be successfully signed in

  Scenario: Successful logout
     Given a logged in user
     When I logout
     Then the system should log me out of the system
     And I should not be able to use the features available only to logged in users

  Scenario Outline: Failed Login
     Given the login id is "correct@email.com" and password is "secret_Word"
     When I enter "<login>" and "<password>"
     Then the message should be "<message>"

  Scenarios: wrong login credentials
     | login               | password         | message                    |
     | correct@email.com   | secret_Word      | Signed in successfully     |
     | wrong@email.com     | secret_Word      | Invalid email or password  |
     | correct@email.com   | wrong_password   | Invalid email or password  |
     | wrong@email.com     | wrong_password   | Invalid email or password  |
