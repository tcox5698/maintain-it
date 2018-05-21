require 'rails_helper'

RSpec.describe ScheduledChore, type: :model do
  let(:chore){FactoryBot.create(:chore)}
  it 'validates presence of due' do
    expect {ScheduledChore.create!(attributes = { due: nil, chore: chore, site: chore.site})}
      .to raise_error "Validation failed: Due can't be blank"
  end

  it 'validates presence of site' do
    expect {ScheduledChore.create!(attributes = { due: Time.now, chore: chore, site: nil})}
      .to raise_error "Validation failed: Site must exist"
  end

  it 'validates presence of chore' do
    expect {ScheduledChore.create!(attributes = { due: Time.now, chore: nil, site: chore.site})}
      .to raise_error "Validation failed: Chore must exist"
  end
end
