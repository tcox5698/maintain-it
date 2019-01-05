When(/^the job "([^"]*)" executes$/) do |job_name|
  job_name.constantize.perform_now
end
