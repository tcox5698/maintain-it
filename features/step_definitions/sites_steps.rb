# frozen_string_literal: true

Then(/^I see the Sites page$/) do
  expect(page).to have_content('New Site')
end

And(/^I visit the Sites page$/) do
  visit_sites_page
end

def create_site(site_name)
  visit_sites_page
  click_link 'New Site'
  page.fill_in 'site_name', with: site_name
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

Then(/^I can change the name of site '(.*)' to '(.*)'$/) do |_site_name, new_site_name|
  click_link 'Edit'
  page.fill_in 'site_name', with: new_site_name.to_s
  click_button 'Update Site'
  expect(page).to have_content('Site was successfully updated.')
  visit_sites_page
  expect(page).to have_xpath("//td[.='#{new_site_name}']")
end

And(/^I can delete the site '(.*)'$/) do |site_name|
  visit_sites_page
  destroy_link = page.find(:xpath, "//tbody/tr[td[.='#{site_name}']]/td[6]/a")
  accept_confirm do
    destroy_link.click
  end
  expect(page).to have_content('Site was successfully destroyed.')
end

And(/^I select my site$/) do
  expect(page).to have_xpath("//input[@type='radio']")
  site_radio = page.first(:xpath, "//input[@type='radio']")
  site_radio.click
end

Given(/^'(.*)' has created a site '(.*)'$/) do |email, site_name|
  make_a_user(email)
  visit '/'
  click_link 'Login'
  log_in(email, 'Password7!')
  create_site(site_name)
  logout
end

Then(/^I do not see '(.*)'$/) do |site_name|
  expect(page).not_to have_content(site_name)
end

Then(/^I see the site '(.*)'$/) do |site_name|
  expect(page).to have_content "Name: #{site_name}"
end

Given(/^the following users have the following roles and statuses at the following sites$/) do |table|
  # table is a table.hashes.keys # => [:user, :site, :role, :status]
  table.hashes.each do |row|
    user = User.find_by_email(row[:user])
    unless user
      user = User.create!(
        email: row[:user],
        password: 'Password7!',
        password_confirmation: 'Password7!'
      )
      user.skip_confirmation!
      user.save
    end
    site = Site.find_by_name(row[:site])
    site ||= Site.create!(name: row[:site])
    SiteMember.create!(site: site, user: user, role: row[:role], status: row[:status])
  end
end

Then(/^user '(.*)' sees the following list on the Sites page$/) do |email, table|
  # table is a table.hashes.keys # => [:Site, :Role, :Present]
  visit '/'
  click_link 'Login'
  log_in(email, 'Password7!')
  expect(page).to have_content email
  click_link 'Sites'

  expect(page).to have_content 'Sites'

  table.hashes.each do |expected|
    expect(page).to have_content expected[:Site]
    actual = find(:xpath, "//tbody/tr[td[contains(.,'#{expected[:Site]}')]]")
    expect(actual).not_to be_nil
    expect(actual).to have_content expected[:Role]
    expect(actual).to have_content expected[:Present]
  end

  click_link 'Logout'
end

And(/^Site "([^"]*)" is in timezone "([^"]*)"$/) do |site_name, time_zone_name|
  site = Site.find_by name: site_name
  site.time_zone = time_zone_name
  site.save
end
