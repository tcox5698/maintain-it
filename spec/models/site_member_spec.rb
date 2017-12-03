require 'rails_helper'

RSpec.describe SiteMember, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let(:site) {FactoryGirl.create(:site)}

  context 'when created without nickname' do
    subject {SiteMember.new(attributes={ user: user, site: site})}

    it 'has the nickname deduced from the email' do
      expect(subject.nick_name).to eq 'factorygirl'
    end
  end

  context 'when created with user and site and nickname' do
    subject {SiteMember.new(attributes={ user: user, site: site, nick_name: 'fake nickname' })}

    it 'has the input site' do
      expect(subject.site).to be site
    end

    it 'has the input user' do
      expect(subject.user).to be user
    end

    it 'has the nick name' do
      expect(subject.nick_name).to eq 'fake nickname'
    end

    it 'requires a site' do
      expected_message = 'Validation failed: User must exist, Site must exist'
      expect {
        SiteMember.create!(attributes={ nick_name: 'fake nickname' })
      }.to raise_error expected_message
    end
  end
end
