When(/^I visit the home page$/) do
  visit '/'
end

Then(/^I see the welcome page$/) do
  expect(page).to have_content 'Welcome'
end

And(/^I see a registration link$/) do
  expect(page).to have_link('Sign up!')
end
