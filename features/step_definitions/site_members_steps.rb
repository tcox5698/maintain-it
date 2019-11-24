# frozen_string_literal: true

When(/^I visit the Site Members page of Site "([^"]*)"$/) do |_site_name|
  click_link 'Site Members'
end
