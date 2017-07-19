When(/^a visitor goes to the home page$/) do
  visit '/'
end

Then(/^they see the welcome page$/) do
  expect(page).to have_content 'Welcome'
end