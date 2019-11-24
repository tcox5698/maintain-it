require "rails_helper"

RSpec.describe ScheduledChoresMailer, type: :mailer do
  describe "#chores_email" do
    let(:user) { FactoryBot.create(:user) }
    let(:user_other) { FactoryBot.create(:user, email: 'other@example.com') }
    let(:site_member) { FactoryBot.create(:site_member, user: user) }
    let(:site) { site_member.site }
    let(:chore) { create :chore, site: site_member.site }

    context "when site has a scheduled chore" do
      let(:scheduled_chore) { create :scheduled_chore, chore: chore, site: site_member.site }

      before do
        expect(site_member_other).not_to be_nil
        expect(site.site_members.size).to eq 2
        expect(site.scheduled_chores).to include scheduled_chore
        mailer = ScheduledChoresMailer.with({ site: site })
        @mail = mailer.chores_email
      end

      context "when all members' email notification channels are enabled" do
        let(:site_member_other) { FactoryBot.create(:site_member, site: site, user: user_other) }

        describe "the email" do
          it "has the 'time for chores' subject" do
            expect(@mail.subject).to eq "MaintainIt! It's time to get some chores done!"
          end

          it 'is addressed bcc to the site_members)' do
            expect(@mail.to).to be_nil
            expect(@mail.bcc).to eq site.site_members.map { |m| m.user.email }
          end

          it 'lists the chores' do
            expect(@mail.body.to_s).to include chore.name
          end
        end
      end
      
      context "when one member's email notification channel is not enabled" do
        let(:site_member_other) do
          other_member = FactoryBot.create(:site_member, site: site, user: user_other)
          channel = other_member.notification_channels.first
          channel.update({enabled: false})
          other_member
        end

        before do
          expect(site_member_other.notification_channels.first.enabled).to be_falsey
        end

        describe "the email" do
          it "has the 'time for chores' subject" do
            expect(@mail.subject).to eq "MaintainIt! It's time to get some chores done!"
          end

          it 'is addressed bcc to the site_members with enabled channels)' do
            expect(@mail.to).to be_nil
            expect(@mail.bcc).to eq [site_member.user.email]
          end

          it 'lists the chores' do
            expect(@mail.body.to_s).to include chore.name
          end
        end
      end
    end
  end
end
