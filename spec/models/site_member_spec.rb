require 'rails_helper'

RSpec.describe SiteMember, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:site) { FactoryBot.create(:site) }

  describe '#create' do
    it 'validates user is present' do
      expect { SiteMember.create!(attributes = { site: site }) }.to raise_error 'Validation failed: User must exist'
    end

    it 'has a single notification channel of type "email"' do
      member = SiteMember.create!(attributes = { user: user, site: site })

      expect(member.notification_channels.size).to eq 1
      expect(member.notification_channels.first.channel_type).to eq NotificationChannel::TYPE_EMAIL
    end

    context 'when created without nickname' do
      subject { SiteMember.create!(attributes = { user: user, site: site }) }

      it 'has the nickname deduced from the email' do
        expect(subject.nick_name).to eq 'factorybot'
      end
    end

    it 'requires a site' do
      expected_message = 'Validation failed: User must exist, Site must exist'
      expect {
        SiteMember.create!(attributes = { nick_name: 'fake nickname' })
      }.to raise_error expected_message
    end

    context 'when created with user and site and nickname' do
      subject {
        SiteMember.create!(attributes = { user: user, site: site, nick_name: 'fake nickname' })
      }

      it 'has the input site' do
        expect(subject.site).to be site
      end

      it 'has the input user' do
        expect(subject.user).to be user
      end

      it 'has the nick name' do
        expect(subject.nick_name).to eq 'fake nickname'
      end

      it 'has the role "visitor"' do
        expect(subject.role).to eq 'visitor'
      end

      it 'has the status "absent"' do
        expect(subject.status).to eq 'absent'
      end
    end

    context 'when created with role "host"' do
      subject { SiteMember.new(attributes = { user: user, site: site, nick_name: 'fake nickname', role: 'host' }) }

      it 'has the role "host"' do
        expect(subject.role).to eq 'host'
      end
    end
  end

  describe '.destroy' do
    it 'cascades to NotificationChannel' do
      site_member = SiteMember.create!(attributes = { user: user, site: site, nick_name: 'fake nickname' })
      expect(NotificationChannel.count).to eq 1

      site_member.destroy
      expect(NotificationChannel.count).to eq 0
    end
  end

  context 'when updated to have nil role' do
    it 'raises error"' do
      expected_message = "Validation failed: Role can't be blank"
      member = SiteMember.create!(attributes = { nick_name: 'fake nickname', site: site, user: user })
      member.role = nil

      expect { member.save! }.to raise_error expected_message
    end
  end

  describe '.channel_enabled?' do
    let(:email_channel_enabled) { true }
    let(:site_member) { SiteMember.create!(attributes = { user: user, site: site }) }
    before do
      site_member.notification_channel('email').update({ enabled: email_channel_enabled })
    end

    context 'when email channel enabled' do
      it 'returns true' do
        expect(site_member.notification_channel_enabled?('email')).to be_truthy
      end
    end

    context 'when email channel not enabled' do
      let(:email_channel_enabled) { false }

      it 'returns false' do
        expect(site_member.notification_channel_enabled?('email')).to be_falsey
      end
    end
    
    context 'when channel not configured' do
      it 'returns false' do
        expect(site_member.notification_channel_enabled?('carrier_pidgeon')).to be_falsey
      end
    end
  end
end
