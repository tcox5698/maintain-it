@javascript
Feature: I can register as a user

  Scenario: I can register
    When I visit the home page
    And I click the registration link
    Then I see the registration page
    When I enter my new username 'test@example.com' and password 'Password7!' and submit
    Then I see a notification 'A message with a confirmation link has been sent to your email address.'
    When I click the confirmation link in the confirmation email
    Then I see a notification 'Your email address has been successfully confirmed.'
    When I log in with username 'test@example.com' and password 'Password7!'
    And I visit the Sites page
    Then I see the Sites page
    
