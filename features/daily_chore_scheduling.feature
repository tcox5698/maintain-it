@javascript
Feature: As a site member, I can view and be notified of scheduled chores.

  Scenario: Site Host sees daily chores scheduled once and only once for the day and is notified
    Given Site Host "sitehost@example.com" with a single Site "My Beautiful Home" is logged in
    And Site Host "sitehost@example.com" has created the following chores
      | SiteName          | ChoreName    | ChoreDescription    | ChoreSchedule |
      | My Beautiful Home | chore 1 name | chore 1 description | Daily         |
      | My Beautiful Home | chore 2 name | chore 2 description | Daily         |
    And Site "My Beautiful Home" is in timezone "America/Chicago"
    And the current UTC datetime is "4/Feb/2017 01:00:00"
    When the job "ScheduleChoresJob" executes
    Then Site Host "sitehost@example.com" sees the following chores schedule for Site "My Beautiful Home"
      | ChoreName    | ChoreDescription    | Due                      |
      | chore 1 name | chore 1 description | February 3rd, 2017 21:59 |
      | chore 2 name | chore 2 description | February 3rd, 2017 21:59 |
    When the job "ScheduleChoresJob" executes
    Then Site Host "sitehost@example.com" sees the following chores schedule for Site "My Beautiful Home"
      | ChoreName    | ChoreDescription    | Due                      |
      | chore 1 name | chore 1 description | February 3rd, 2017 21:59 |
      | chore 2 name | chore 2 description | February 3rd, 2017 21:59 |
    When the job "NotifyScheduledChoresJob" executes
    And delayed jobs are being dispatched
    Then an email is sent to "sitehost@example.com" with the following scheduled chores
      | ChoreName    | ChoreDescription    | Due                      |
      | chore 1 name | chore 1 description | February 4, 2017 03:59 |
      | chore 2 name | chore 2 description | February 4, 2017 03:59 |


    
