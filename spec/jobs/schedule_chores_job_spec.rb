require 'rails_helper'

RSpec.describe ScheduleChoresJob, type: :job do
  describe "#perform" do
    context "when no chores exist" do
      before do
        ScheduleChoresJob.perform_now
      end

      context "when no chores exist" do
        it "does nothing" do
          expect(ScheduledChore.count).to eq 0
        end
      end
    end

    context 'when chore exists' do
      let(:site_time_zone) {'Australia/Melbourne'}
      let(:site) {FactoryBot.create(:site, time_zone: site_time_zone)}
      let(:chore) {FactoryBot.create(:chore, site: site)}

      before do
        expect(chore.name).to eq "MyString"
        ScheduleChoresJob.perform_now
      end

      context 'when chore has not been scheduled for today' do
        describe "the scheduled chore" do
          subject(:actual) {ScheduledChore.all.first}
          it "is not nil" do
            expect(actual).not_to be_nil
          end

          it "has the chore" do
            expect(actual.chore.id).to eq chore.id
          end

          context "when site in time zone America/Chicago" do
            let(:site_time_zone) {'America/Chicago'}
            it "has due equal to 10 pm today central time" do
              require 'active_support/values/time_zone.rb'

              Time.use_zone(site_time_zone) do
                ten_pm_today = Time.zone.now.end_of_day - 2.hours
                expect(actual.due.to_s).to eq ten_pm_today.to_s
              end
            end
          end

          context "when site in time zone Pacific/Tongatapu" do
            let(:site_time_zone) {'Pacific/Tongatapu'}
            it "has due equal to 10 pm today Pacific/Tongatapu time" do
              require 'active_support/values/time_zone.rb'

              Time.use_zone(site_time_zone) do
                ten_pm_today = Time.zone.now.end_of_day - 2.hours
                expect(actual.due.to_s).to eq ten_pm_today.to_s
              end
            end
          end
        end
      end
    end
  end
end
