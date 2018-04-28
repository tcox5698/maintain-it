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

  table.hashes.each do |expected_row|
    puts "expected row: #{expected_row.inspect}"
    expect(page).to have_content expected_row[:Email]

    actual_rows = page.all(:xpath, "//tbody/tr")
    actual_row = actual_rows.select {|r| r.has_content?(expected_row[:Email])}.take(1).first
    expect(actual_row).not_to be_nil

    puts "actual row: #{actual_row.text}"

    expect(actual_row).to have_content(expected_row[:Email])
    expect(actual_row).to have_content(expected_row[:Name])
    expect(actual_row).to have_content(expected_row[:Role])
    expect(actual_row).to have_content(expected_row[:Status])
  end
end


And(/^user "([^"]*)" is a member of Site "([^"]*)"$/) do |email, site_name|
  site = Site.find_by_name(site_name)
  user = User.find_by_email(email)

  SiteMember.create!(site: site, user: user)
end
