Then(/^I see a notification '(.*)'$/) do | expected_message|
  expect(page).to have_content(expected_message)
end


When(/^I log in with username '(.*)' and password '(.*)'$/) do |user_name, password|
  fill_in 'Email', with: user_name
  fill_in 'Password', with: password
  click_button 'Log in'
end


And(/^I visit the Sites page$/) do
  click_link 'Sites'
end
