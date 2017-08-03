Then(/^I see the Sites page$/) do
  expect(page).to have_content('New Site')
end