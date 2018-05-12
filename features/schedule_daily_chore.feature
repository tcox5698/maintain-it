@javascript
Feature: As a host I can schedule a daily chore so the app can call attention to the chore once a day

  Scenario: Host schedules a daily chore
    Given Site Host "host@example" with a single Site "My Beautiful Home" is logged in
    And I click "New Chore"
    Then I see the "New Chore" page
    And I select my site
    And I enter the following chore information and save
      | Name        | Description            |
      | Sweep Docks | Please sweep the docks |
    And I click "Back"
    Then I see this list of chores for site "My Beautiful Home"
      | Name        | Description            | Schedule | Site              |
      | Sweep Docks | Please sweep the docks | Daily    | My Beautiful Home |
