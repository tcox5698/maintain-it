# frozen_string_literal: true

Then(/^an email is sent to "([^"]*)" with the following scheduled chores$/) do |email_address, expected_chores|
  # expected chores is table with :ChoreName, :ChoreDescription, :Due

  sleep 2

  notification_email = ActionMailer::Base.deliveries.last
  expect(notification_email.bcc[0]).to eq email_address
  expect(notification_email.subject).to eq "MaintainIt! It's time to get some chores done!"
  expected_chores.hashes.each do |expected_row|
    expect(notification_email.body).to include expected_row[:ChoreName]
    expect(notification_email.body).to include expected_row[:ChoreDescription]
    expect(notification_email.body).to include expected_row[:Due]
  end
end
