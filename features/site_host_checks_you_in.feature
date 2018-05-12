@javascript
Feature: Host checks a visitor in

  Scenario: Host checks in Visitor who is a new user
    Given a new user "visitor@example.com"
    Given Site Host "host@example.com" with a single Site "My Beautiful Home" is logged in
    When I click "Check in a Visitor"
    Then I see my sites
    And I select my site
    And I enter email "visitor@example.com" and click OK
    Then visitor "visitor@example.com" receives a site welcome email
    And I see the following Site Members of Site "Home"
      | Name    | Email               | Role    | Status  |
      | Host    | host@example.com    | Host    | Present |
      | Visitor | visitor@example.com | Visitor | Present |

  Scenario: host checks in an existing user but new Site Member
    Given an existing user "existinguser@example.com"
    Given Site Host "host@example.com" with a single Site "My Beautiful Home" is logged in
    When I click "Check in a Visitor"
    And I select my site
    And I enter email "existinguser@example.com" and click OK
    And I see the following Site Members of Site "Home"
      | Name    | Email                    | Role    | Status  |
      | Host    | host@example.com         | Host    | Present |
      | Visitor | existinguser@example.com | Visitor | Present |

  Scenario: host checks in an existing user who is already a Site Member
    Given an existing user "existinguser@example.com"
    Given Site Host "host@example.com" with a single Site "My Beautiful Home" is logged in
    And user "existinguser@example.com" is a member of Site "My Beautiful Home"
    When I visit the Site Members page of Site "My Beautiful Home"
    Then I see the following Site Members of Site "My Beautiful Home"
      | Name    | Email                    | Role    | Status  |
      | Host    | host@example.com         | Host    | Present |
      | Visitor | existinguser@example.com | Visitor | Absent  |
    When I click "Check in a Visitor"
    And I select my site
    And I enter email "existinguser@example.com" and click OK
    And I see the following Site Members of Site "Home"
      | Name    | Email                    | Role    | Status  |
      | Host    | host@example.com         | Host    | Present |
      | Visitor | existinguser@example.com | Visitor | Present |
