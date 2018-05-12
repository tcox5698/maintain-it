Feature: As a site member, I will be notified of today's chores.

  Scenario: Checked in site member gets morning notification when there is a daily chore
    Given Site Host "sitehost@example" with a single Site "My Beautiful Home" is logged in
    And Site Host "sitehost@example.com" has created the following chores
      | SiteName          | ChoreName    | ChoreDescription    | ChoreSchedule |
      | My Beautiful Home | chore 1 name | chore 1 description | Daily         |
#    And Site Host "sitehost@example.com" lives in timezone "America/Chicago"
#    And the current UTC date is "February 4, 2017" and the time is "1:00 am"
#    When the job "schedule chores" executes
#    Then Site Host "sitehost@example.com" sees the following scheduled chores for Site "My Beautiful Home"
#      | ChoreName    | ChoreDescription    | Due   |
#      | chore 1 name | chore 1 description | Today |

    
    
