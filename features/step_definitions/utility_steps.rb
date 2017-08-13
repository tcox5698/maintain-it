Then(/^I see a notification '(.*)'$/) do | expected_message|
  expect(page).to have_content(expected_message)
end

When(/^I log in with username '(.*)' and password '(.*)'$/) do |user_name, password|
  log_in(user_name, password)
end

Given(/^I am logged in as '(.*)'$/) do |user_name|
  register_and_login(user_name)
end
