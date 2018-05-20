require 'rails_helper'

RSpec.describe ScheduleChoresJob, type: :job do
  describe "#perform" do
    before do
      ScheduleChoresJob.perform_now
    end
    context "when no chores exist" do
      it "does nothing" do
        pending
        expect(ScheduledChores.count).to eq 0
      end
    end
  end
end
