@javascript
Feature: Host checks a visitor in

  Scenario: Host checks in Visitor who is a new user
    Given a new visitor "visitor@example.com"
    Given I am logged in as a Site Host with a single Site "Home"
    When I click "Check In a Visitor"
    And I select my site
    And I enter email "visitor@example.com" and click OK
    Then visitor "visitor@example.com" receives a site welcome email
    And I see the following Site Members of Site "Home"
      | Name  | Email               | Role        | Status  |
      | Host  | host@example.com    | Site Host   | On Site |
      | Nancy | visitor@example.com | Site Member | On Site |

#  Scenario: host checks in an existing user but new Site Member
#
#  Scenario: host checks in a Visitor who is already a Site Member

#  Scenario: Visitor can not check in other visitors

#  Scenario: Visitor can not edit Site


