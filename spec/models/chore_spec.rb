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

  describe "#already_scheduled?" do
    let(:chore) {FactoryBot.create(:chore)}
    before do
      Time.use_zone(chore.site.time_zone) do
        ScheduledChore.create!(chore: chore, site: chore.site, due: Time.zone.now.end_of_day - 2.hours)
      end
    end

    context "when due in future" do
      it "is true" do
        expect(chore.already_scheduled?).to be_truthy
      end
    end

    context "when due in past" do
      before do
        Time.use_zone(chore.site.time_zone) do
          travel_to Time.zone.now.end_of_day - 1.hour
        end
      end

      after do
        travel_back
      end

      it "is false" do
        expect(chore.already_scheduled?).to be_falsey
      end
    end
  end
end
