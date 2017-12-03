@javascript
Feature: Manage sites

  Scenario: I can create a site with a name and address
    Given I am logged in as 'bob@example.com'
    When I create a new Site 'My New Site'
    Then I see 'My New Site' in the list of Sites
    Then I can change the name of site 'My New Site' to 'new site name'
    And I can delete the site 'new site name'

  Scenario: Other users can not see or edit a site
    Given 'bob@example.com' has created a site 'Bob Site'
    And I am logged in as 'nancy@example.com'
    When I visit the Sites page
    Then I do not see 'Bob Site'
    When I create a new Site 'Nancy Site'
    Then I see 'Nancy Site' in the list of Sites
    And I do not see 'Bob Site'
    Then I can change the name of site 'Nancy Site' to 'new site name'
    When I visit the Sites page
    Then I see 'new site name' in the list of Sites

  Scenario: Users see their roles and statuses at their sites
    Given the following users have the following roles and statuses at the following sites
      | user              | site        | role    | status  |
      | bob@example.com   | BobPlace1   | host    | present |
      | nancy@example.com | NancyPlace1 | host    | present |
      | nancy@example.com | BobPlace1   | visitor | absent  |
    Then 'bob@example.com' sees the following list on the Sites page
      | Site      | Role | Status  |
      | BobPlace1 | Host | Present |
    And 'nancy@example.com' sees the following list on the Sites page
      | Site        | Role    | Status  |
      | NancyPlace1 | Host    | Present |
      | BobPlace1   | Visitor |         |
