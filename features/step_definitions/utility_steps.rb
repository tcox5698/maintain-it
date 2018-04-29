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


Given(/^I am logged in as a Site Host with a single Site "([^"]*)"$/) do |site_name|
  make_a_user("host@example.com")
  visit "/"
  click_link "Login"
  log_in("host@example.com", "Password7!")
  create_site(site_name)
end


Given(/^an existing user "([^"]*)"$/) do |email|
  User.create!(email: email, password: "Password7!")
end
