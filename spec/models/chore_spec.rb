require 'rails_helper'

RSpec.describe Chore, type: :model do
  let(:site) {FactoryBot.create(:site)}
  it 'validates presence of name' do
    expect {Chore.create!(attributes = { description: "fake desc", site: site })}
      .to raise_error "Validation failed: Name can't be blank"
  end

  it 'validates presence of site' do
    expect {Chore.create!(attributes = { name: "fake name", description: "fake desc" })}
      .to raise_error "Validation failed: Site must exist"
  end

  it 'defaults schedule to daily' do
    chore = Chore.create!(attributes = { name: "fake name", description: "fake desc", site: site })
    expect(chore.schedule).to eq "daily"
  end

  it 'only accepts daily' do
    expect {Chore.create!(attributes = {
      name: "fake name",
      description: "fake desc",
      site: site,
      schedule: "alternate tuesdays"
    })}
      .to raise_error "Validation failed: Schedule alternate tuesdays is not a supported schedule. Try 'daily'"
  end
end
