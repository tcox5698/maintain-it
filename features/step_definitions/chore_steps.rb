Then(/^I see the "([^"]*)" page$/) do |title|
  expect(page).to have_content title
end


And(/^I enter the following chore information and save$/) do |table|
  # table is a table.hashes.keys # => [:Name, :Description]
  inputs = table.hashes.first
  page.fill_in 'chore[name]', :with => inputs[:Name]
  page.fill_in 'chore[description]', :with => inputs[:Description]
  page.click_on 'Create Chore'
  expect(page).to have_content('Chore was successfully created.')
end


Then(/^I see this list of chores for site "([^"]*)"$/) do |site_name, table|
  # table is a table.hashes.keys # => [:Name, :Description, :Schedule]
  table.hashes.each do |expected|
    expect(page).to have_content expected[:Name]
    actual = find(:xpath, "//tbody/tr[td[contains(.,'#{expected[:Name]}')]]")
    expect(actual).not_to be_nil
    expect(actual).to have_content expected[:Description]
    expect(actual).to have_content expected[:Schedule]
  end
end
