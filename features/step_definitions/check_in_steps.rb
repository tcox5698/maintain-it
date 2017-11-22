When(/^I click "([^"]*)"$/) do |link|
  expect(page).to have_link(link)
  click_link(link)
end


Then(/^I see my sites$/) do
  expect(page).to have_xpath('//table')
  table = page.first(:xpath, '//table')
  expect(table).to have_content('My Beautiful Home')
end


And(/^I select my site$/) do
  expect(page).to have_xpath("//input[@type='radio']")
  site_radio = page.first(:xpath, "//input[@type='radio']")
  site_radio.click()
end


And(/^I enter email "([^"]*)" and click OK$/) do |email|
  page.fill_in "email", :with => email
  page.click_on 'Check in visitor'
end


Then(/^visitor "([^"]*)" receives a site welcome email$/) do |input_email|
  email = ActionMailer::Base.deliveries.last
  page = Nokogiri::HTML(email.body.to_s)
  expect(email["to"].to_s).to eq input_email
  expect(page).to have_content(input_email)
end


And(/^I see the following Site Members of Site "([^"]*)"$/) do |site_name, table|
  # table is a table.hashes.keys # => [:Name, :Email, :Role, :Status]
  table.hashes.find do | row |
    expected_email = row[:Email]
    expect(page).to have_content(expected_email)
  end
end
