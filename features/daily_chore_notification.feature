@javascript
Feature: As a site member, I will be notified of today's chores.

  Scenario: Checked in site member gets morning notification when there is a daily chore
    Given Site Host "sitehost@example" with a single Site "My Beautiful Home" is logged in
    And Site Host "sitehost@example.com" has created the following chores
      | SiteName          | ChoreName    | ChoreDescription    | ChoreSchedule |
      | My Beautiful Home | chore 1 name | chore 1 description | Daily         |
    And Site "My Beautiful Home" is in timezone "America/Chicago"
    And the current UTC datetime is "4/Feb/2017 01:00:00"
    When the job "schedule_chores" executes
    Then Site Host "sitehost@example.com" sees the following chores schedule for Site "My Beautiful Home"
      | ChoreName    | ChoreDescription    | Due   |
      | chore 1 name | chore 1 description | Today |

    
    
