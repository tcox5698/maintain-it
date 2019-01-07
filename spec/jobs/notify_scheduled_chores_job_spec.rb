require 'rails_helper'
require 'active_support/testing/time_helpers'

RSpec.describe NotifyScheduledChoresJob, type: :job do
  describe "#perform" do
    context "happy path - site has owner and daily-scheduled chores" do
      let(:site_member) {create :site_member, role: 'host'}
      let(:chore) {create :chore, site: site_member.site}
      let(:scheduled_chore) {create :scheduled_chore, chore: chore, site: site_member.site}
      let(:expected_chores) {[scheduled_chore]}
      let(:mock_email) {double('mock_email', deliver_later: nil)}
      
      before do
        expect(scheduled_chore.chore.name).to eq 'FactoryChoreName'
        expect(expected_chores.length).to eq 1
        allow(ScheduledChoresMailer).to receive(:chores_email).and_return mock_email
        NotifyScheduledChoresJob.perform_now
      end

      it "sends email with chores" do
        expect(ScheduledChoresMailer).to have_received(:chores_email).with(site_member: site_member, scheduled_chores: expected_chores)
        expect(mock_email).to have_received(:deliver_later)
      end

      context "second time in 24 hours" do
        it "does not re-send the email to anyone"
      end

      context "second time *after* 24 hours" do
        it "sends the new notification"
      end
    end
  end
end
