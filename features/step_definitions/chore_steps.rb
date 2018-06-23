Then(/^I see the "([^"]*)" page$/) do |title|
  expect(page).to have_content title
end


And(/^I enter the following chore information and save$/) do |table|
  inputs = table.hashes.first
  page.fill_in 'chore[name]', :with => inputs[:ChoreName]
  page.fill_in 'chore[description]', :with => inputs[:ChoreDescription]
  page.click_on 'Create Chore'
  expect(page).to have_content('Chore was successfully created.')
end


def assert_chores_displayed(table)
  table.hashes.each do |expected|
    expect(page).to have_content expected[:ChoreName]
    actual = find(:xpath, "//tbody/tr[td[contains(.,'#{expected[:ChoreName]}')]]")
    expect(actual).not_to be_nil
    expect(actual).to have_content expected[:ChoreDescription]
    expect(actual).to have_content expected[:Schedule]
  end
end

Then(/^I see this list of chores for site "([^"]*)"$/) do |site_name, table|
  # table is a table.hashes.keys # => [:ChoreName, :ChoreDescription, :Schedule]
  assert_chores_displayed(table)
end


And(/^Site Host "([^"]*)" has created the following chores$/) do |email, table|
  # table is a table.hashes.keys # => [:SiteName, :ChoreName, :ChoreDescription, :ChoreSchedule]

  # create the chores
  table.hashes.each do |chore|
    site = Site.find_by! name: chore[:SiteName]

    Chore.create!(name: chore[:ChoreName], description: chore[:ChoreDescription],
                  schedule: chore[:ChoreSchedule].downcase, site: site)
  end

  visit("/chores")
  assert_chores_displayed(table)
end


Then(/^Site Host "([^"]*)" sees the following chores schedule for Site "([^"]*)"$/) do |email, site_name, table|
  # table is a table.hashes.keys # => [:ChoreName, :ChoreDescription, :Due]
  visit("/scheduled_chores")

  rows = page.find(:xpath, "//tbody/tr")

  table.hashes.each do |expected|
    expect(page).to have_content expected[:ChoreName]
    actual = find(:xpath, "//tbody/tr[td[contains(.,'#{expected[:ChoreName]}')]]")
    expect(actual).not_to be_nil
    expect(actual).to have_content expected[:ChoreDescription]
    expect(actual).to have_content expected[:Due]
  end
end
