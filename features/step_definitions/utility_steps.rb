Then(/^I see a notification '(.*)'$/) do | expected_message|
  expect(page).to have_content(expected_message)
end

When(/^I log in with username '(.*)' and password '(.*)'$/) do |user_name, password|
  log_in(user_name, password)
end

Given(/^I am logged in as '(.*)'$/) do |user_name|
  make_a_user(user_name)
  visit "/"
  click_link "Login"
  log_in(user_name, "Password7!")
end


Given(/^a new user "([^"]*)"$/) do |email|
  expect(User.find_by_email(email)).to be_nil
end


Given(/^Site Host "([^"]*)" with a single Site "([^"]*)" is logged in$/) do |site_host, site_name|
  make_a_user(site_host)
  visit "/"
  click_link "Login"
  log_in(site_host, "Password7!")
  create_site(site_name)
end


Given(/^an existing user "([^"]*)"$/) do |email|
  User.create!(email: email, password: "Password7!")
end
