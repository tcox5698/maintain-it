Then(/^an email is sent to "([^"]*)" with the following scheduled chores$/) do |email_address, expected_chores|
  notification_email = ActionMailer::Base.deliveries.last
  expect(notification_email.to[0]).to eq email_address
  expect(notification_email.subject).to eq "MaintainIt! It's time to get some chores done!"
  table.hashes.each do |expected|
    expect(notification_email.body).to include "MaintainIt! It's time to get some chores done!"
  end
end
