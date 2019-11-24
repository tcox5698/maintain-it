# frozen_string_literal: true

And(/^I click the registration link$/) do
  expect(page).to have_link('Sign Up!')
  click_link('Sign Up!', match: :first)
end

Then(/^I see the registration page$/) do
  expect(page).to have_content('Sign up')
end

When(/^I enter my new username '(.*)' and password '(.*)' and submit$/) do |user_name, password|
  expect(page).to have_content('Email')
  enter_registration_info(user_name, password)
end

When(/^I click the confirmation link in the confirmation email$/) do
  click_email_confirmation_link
end

And(/^I receive a confirmation email from 'noreply@tcdevllc\.com'$/) do
  email = ActionMailer::Base.deliveries.last
  expect(email.from).to eq ['noreply@tcdevllc.com']
end
