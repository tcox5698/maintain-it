require 'rails_helper'
require 'active_support/testing/time_helpers'

RSpec.describe ScheduleChoresJob, type: :job do
  let(:site_time_zone) {'Australia/Melbourne'}
  let(:fake_now) do
    Time.use_zone(site_time_zone) do
      Time.zone.now
    end
  end

  after do
    travel_back
  end

  describe "#perform" do
    context "when no chores exist" do
      before do
        travel_to fake_now
        ScheduleChoresJob.perform_now
      end

      context "when no chores exist" do
        it "does nothing" do
          expect(ScheduledChore.count).to eq 0
        end
      end
    end

    context 'when chore exists for today' do
      let(:site) {FactoryBot.create(:site, time_zone: site_time_zone)}
      let(:chore) {FactoryBot.create(:chore, site: site)}

      before do
        expect(chore.name).to eq "MyString"

        Time.use_zone(site.time_zone) do
          fake_time = Time.zone.now.beginning_of_day + 4.hours
          travel_to(fake_time)
          ScheduleChoresJob.perform_now
        end

      end

      context 'when chore has already been scheduled for today' do
        before do
          expect(ScheduledChore.count).to eq 1
          ScheduleChoresJob.perform_now
        end

        it 'does not schedule the chore again for today' do
          expect(ScheduledChore.count).to eq 1
        end
      end

      context 'when chore has not been scheduled for today' do

        it 'schedules a single chore' do
          expect(ScheduledChore.count).to eq 1
        end

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

            context 'and now is before 10 pm' do
              let(:fake_now) do
                Time.use_zone(site_time_zone) do
                  Time.zone.now.end_of_day - 121.minutes
                end
              end

              it "has due equal to 10 pm today central time" do
                require 'active_support/values/time_zone.rb'

                Time.use_zone(site_time_zone) do
                  ten_pm_today = Time.zone.now.end_of_day - 2.hours
                  expect(actual.due.to_s).to eq ten_pm_today.to_s
                end
              end
            end
          end

          context "when site in time zone Pacific/Tongatapu" do
            let(:site_time_zone) {'Pacific/Tongatapu'}
            it "has due equal to 10 pm today Pacific/Tongatapu time" do
              Time.use_zone(site_time_zone) do
                ten_pm_today = Time.zone.now.end_of_day - 2.hours
                expect(actual.due.to_s).to eq ten_pm_today.to_s
              end
            end
          end
        end
      end


      context 'when chore was scheduled yesterday' do
        before do
          expect(ScheduledChore.count).to eq 1
          Time.use_zone(site.time_zone) do
            travel_to(Time.zone.now + 1.day)
          end
          ScheduleChoresJob.perform_now
        end

        it 'schedules the chore again for today' do
          expect(ScheduledChore.count).to eq 2
        end
      end
      
      context 'when chore was scheduled today but today is mostly over' do
        before do
          expect(ScheduledChore.count).to eq 1

          Time.use_zone(site.time_zone) do
            puts("   current site time is: #{Time.zone.now.strftime('%FT%T%:z')}" )
            fake_time = Time.zone.now.end_of_day - 1.hour
            travel_to(fake_time)
            ScheduleChoresJob.perform_now
          end
        end

        it 'schedules the chore for tomorrow' do
          expect(ScheduledChore.count).to eq 2
          Time.use_zone(site.time_zone) do
            expect(ScheduledChore.first.due.day).to eq Time.zone.now.day
            expect(ScheduledChore.last.due.day).to eq (Time.zone.now + 1.day).day
          end
        end
      end
    end
  end
end
