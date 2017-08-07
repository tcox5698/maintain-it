require 'rails_helper'

RSpec.describe SiteMember, type: :model do
  context 'when created with user and site' do
    let(:user) {FactoryGirl.create(:user)}
    let(:site) {FactoryGirl.create(:site)}
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
  end
end
