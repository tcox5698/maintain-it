Then(/^I see the Sites page$/) do
  expect(page).to have_content('New Site')
end

And(/^I visit the Sites page$/) do
  click_link 'Sites'
end

When(/^I create a new Site '(.*)'$/) do |site_name|
  click_link 'Sites'
  click_link 'New Site'
  page.fill_in 'Name', :with => site_name
  page.click_on 'Create Site'
  expect(page).to have_content('Site was successfully created.')
end

Then(/^I see '(.*)' in the list of Sites$/) do |site_name|
  click_link 'Sites'
  expect(page.find(:xpath, '//h1')).to have_content('Sites')
  expect(page).to have_xpath("//td[.='#{site_name}']")
end

Then(/^I can edit the name of site '(.*)'$/) do |site_name|
  click_link 'Edit'
  page.fill_in 'Name', :with => "modified #{site_name}"
  click_button 'Update Site'
  expect(page).to have_content('Site was successfully updated.')
  click_link 'Sites'
  expect(page).to have_xpath("//td[.='modified #{site_name}']")
  click_link 'Edit'
  page.fill_in 'Name', :with => "#{site_name}"
  click_button 'Update Site'
end

And(/^I can delete the site '(.*)'$/) do |site_name|
  click_link 'Sites'
  destroy_link = page.find(:xpath, "//tbody/tr[td[.='#{site_name}']]/td[4]/a")
  accept_confirm do
    destroy_link.click
  end
  expect(page).to have_content('Site was successfully destroyed.')
end
