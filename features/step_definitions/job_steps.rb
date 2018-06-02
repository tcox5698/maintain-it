When(/^the job "([^"]*)" executes$/) do |job_name|
  ScheduleChoresJob.perform_now
end
