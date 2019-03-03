require "rails_helper"

RSpec.describe ScheduledChoresMailer, type: :mailer do
  describe "#chores_email" do
    let(:user) {FactoryBot.create(:user)}
    let(:user_other) {FactoryBot.create(:user)}
    let(:site_member) {FactoryBot.create(:site_member, user: user)}
    let(:site) {site_member.site}
    let(:chore) {create :chore, site: site_member.site}
    let(:site_member_other) {FactoryBot.create(:site_member, user: user_other)}

    context "when site has a scheduled chore" do
      let(:scheduled_chore) {create :scheduled_chore, chore: chore, site: site_member.site}

      before do
        expect(site.scheduled_chores).to include scheduled_chore
        dunno = ScheduledChoresMailer.with({ site: site })
        @mail = dunno.chores_email
      end

      describe "the email" do
          it "has the 'time for chores' subject" do
            expect(@mail.subject).to eq "MaintainIt! It's time to get some chores done!"
          end

          it 'is addressed bcc to the site_members)' do
            expect(@mail.to).to be_nil
            expect(@mail.bcc).to eq site.site_members.map{|m|m.user.email}
          end

          it 'lists the chores' do
            expect(@mail.body.to_s).to include chore.name
          end
        end
    end
  end
end
