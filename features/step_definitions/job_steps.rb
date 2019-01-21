When(/^the job "([^"]*)" executes$/) do |job_name|
  job_name.constantize.perform_now
end

Given /^delayed jobs are being dispatched$/ do
  Delayed::Worker.new.work_off
end
