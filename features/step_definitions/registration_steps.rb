And(/^I click the registration link$/) do
  expect(page).to have_link('Sign Up!')
  click_link('Sign Up!', match: :first)
end

Then(/^I see the registration page$/) do
  expect(page).to have_content('Sign up')
end

When(/^I enter my new username '(.*)' and password '(.*)' and submit$/) do |user_name, password|
  expect(page).to have_content('Email')
  page.fill_in 'user[email]', :with => user_name
  page.fill_in 'Password', :with => password
  page.fill_in 'Password confirmation', :with => password
  page.click_on 'Sign up'
end


When(/^I click the confirmation link in the confirmation email$/) do
  email = ActionMailer::Base.deliveries.last
  page = Nokogiri::HTML(email.body.to_s)
  confirm_link = page.xpath('//a').first['href']

  visit confirm_link
end

And(/^I receive a confirmation email from 'noreply@tcdevllc\.com'$/) do
  email = ActionMailer::Base.deliveries.last
  expect(email.from).to eq ['noreply@tcdevllc.com']
end
