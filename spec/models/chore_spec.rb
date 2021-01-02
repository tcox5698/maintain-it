# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chore, type: :model do
  let(:site) { FactoryBot.create(:site) }

  after do
    travel_back
  end

  it 'validates presence of name' do
    expect { Chore.create!(description: 'fake desc', site: site) }
      .to raise_error "Validation failed: Name can't be blank"
  end

  it 'validates presence of site' do
    expect { Chore.create!(name: 'fake name', description: 'fake desc') }
      .to raise_error 'Validation failed: Site must exist'
  end

  it 'defaults schedule to daily' do
    chore = Chore.create!(name: 'fake name', description: 'fake desc', site: site)
    expect(chore.schedule).to eq 'daily'
  end

  it 'only accepts daily' do
    expect do
      Chore.create!(
        name: 'fake name',
        description: 'fake desc',
        site: site,
        schedule: 'alternate tuesdays'
      )
    end
      .to raise_error(
        'Validation failed: Schedule alternate tuesdays is not a'\
        ' supported schedule. Try \'daily\''
      )
  end

  describe '#already_scheduled?' do
    let(:chore) { FactoryBot.create(:chore) }
    before do
      Time.use_zone(chore.site.time_zone) do
        time2200 = Time.zone.now.end_of_day - 2.hours
        ScheduledChore.create!(chore: chore, site: chore.site, due: time2200)
        travel_to fake_now
      end
    end

    context 'when due in future' do
      let(:fake_now) { Time.zone.now.end_of_day - 121.minutes } # 9:59 pm

      it 'is true' do
        expect(chore.already_scheduled?).to be_truthy
      end
    end

    context 'when due in past' do
      let(:fake_now) { Time.zone.now.end_of_day - 119.minutes } # 10:01 pm

      it 'is true' do
        expect(chore.already_scheduled?).to be_truthy
      end
    end
  end
end
