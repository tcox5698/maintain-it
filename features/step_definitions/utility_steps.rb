Then(/^I see a notification '(.*)'$/) do | expected_message|
  expect(page).to have_content(expected_message)
end