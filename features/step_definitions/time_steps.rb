And(/^the current UTC datetime is "([^"]*)"$/) do |date_time_string|
  date_time = date_time_string.to_datetime
  expect(date_time.to_s).to eq "2017-02-04T01:00:00+00:00"
  travel_to(date_time)
  expect(Time.zone.now.to_s).to eq "2017-02-04 01:00:00 UTC"
end
