Then(/^I see a notification '(.*)'$/) do | expected_message|
  expect(page).to have_content(expected_message)
end

When(/^I log in with username '(.*)' and password '(.*)'$/) do |user_name, password|
  log_in(user_name, password)
end

Given(/^I am logged in as '(.*)'$/) do |user_name|
  visit '/'
  click_link('Sign Up!', match: :first)
  enter_registration_info(user_name, 'Password7!')
  click_email_confirmation_link
  log_in(user_name, 'Password7!')
end
