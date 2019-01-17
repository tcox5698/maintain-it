require 'rails_helper'
require 'active_support/testing/time_helpers'

RSpec.describe NotifyScheduledChoresJob, type: :job do
  describe "#perform" do
    context "happy path - site has owner and daily-scheduled chores" do
      let(:other_site) {create :site, name:'other site'}
      let(:site_member) {create :site_member, role: 'host'}
      let(:chore) {create :chore, site: site_member.site}
      let(:scheduled_chore) {create :scheduled_chore, chore: chore, site: site_member.site}
      let(:expected_chores) {[scheduled_chore]}
      let(:mock_emailer) {double('mock_emailer', chores_email: mock_email)}
      let(:mock_email) {double('mock_email', deliver_later: nil)}
      
      before do
        expect(scheduled_chore.chore.name).to eq 'FactoryChoreName'
        expect(expected_chores.length).to eq 1
        allow(ScheduledChoresMailer).to receive(:with).and_return mock_emailer
        NotifyScheduledChoresJob.perform_now
      end

      it "calls ScheduledChoresMailer with sites that have chores" do
        expect(ScheduledChoresMailer).to have_received(:with).with(site: site_member.site)
        expect(mock_emailer).to have_received(:chores_email)
        expect(mock_email).to have_received(:deliver_later)
      end
    end
  end
end
