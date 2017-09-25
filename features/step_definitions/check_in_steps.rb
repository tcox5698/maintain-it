When(/^I click "([^"]*)"$/) do |link|
  expect(page).to have_link(link)
  click_link(link)
end
