@javascript
Feature: Shows welcome landing page

  Scenario: Visitor visits site for first time
    When I visit the home page
    Then I see the welcome page
    And I see a registration link
