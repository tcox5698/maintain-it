Then(/^I see the Sites page$/) do
  expect(page).to have_content('New Site')
end

And(/^I visit the Sites page$/) do
  visit_sites_page
end

def create_site(site_name)
  visit_sites_page
  click_link 'New Site'
  page.fill_in 'Name', :with => site_name
  page.click_on 'Create Site'
  expect(page).to have_content('Site was successfully created.')
end

When(/^I create a new Site '(.*)'$/) do |site_name|
  create_site(site_name)
end

def visit_sites_page
  click_link 'Sites'
  expect(page.find(:xpath, '//h1')).to have_content('Sites')
end

Then(/^I see '(.*)' in the list of Sites$/) do |site_name|
  visit_sites_page
  expect(page).to have_xpath("//td[.='#{site_name}']")
end

Then(/^I can change the name of site '(.*)' to '(.*)'$/) do |site_name, new_site_name|
  click_link 'Edit'
  page.fill_in 'Name', :with => "#{new_site_name}"
  click_button 'Update Site'
  expect(page).to have_content('Site was successfully updated.')
  visit_sites_page
  expect(page).to have_xpath("//td[.='#{new_site_name}']")
end

And(/^I can delete the site '(.*)'$/) do |site_name|
  visit_sites_page
  destroy_link = page.find(:xpath, "//tbody/tr[td[.='#{site_name}']]/td[4]/a")
  accept_confirm do
    destroy_link.click
  end
  expect(page).to have_content('Site was successfully destroyed.')
end

Given(/^'(.*)' has created a site '(.*)'$/) do |user_name, site_name|
  register_and_login(user_name)
  create_site(site_name)
  logout
end

Then(/^I do not see '(.*)'$/) do |site_name|
  expect(page).not_to have_content(site_name)
end

Then(/^I see the site '(.*)'$/) do |site_name|
  expect(page).to have_content "Name: #{site_name}"
end
