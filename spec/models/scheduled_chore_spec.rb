# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScheduledChore, type: :model do
  let(:chore) { FactoryBot.create(:chore) }
  it 'validates presence of due' do
    scheduled_chore = ScheduledChore.new(due: nil, chore: chore, site: chore.site)
    scheduled_chore.due = nil
    expect { scheduled_chore.save! }
      .to raise_error "Validation failed: Due can't be blank"
  end

  it 'validates presence of site' do
    expect { ScheduledChore.create!(due: Time.now, chore: chore, site: nil) }
      .to raise_error 'Validation failed: Site must exist'
  end

  it 'validates presence of chore' do
    expect { ScheduledChore.create!(due: Time.now, chore: nil, site: chore.site) }
      .to raise_error 'Validation failed: Chore must exist'
  end
end
