# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#sites' do
    context 'when multiple users have different sites' do
      it 'returns only the sites for the user' do
        user_bob = FactoryBot.create(:user, email: 'bob@example.com')
        user_nancy = FactoryBot.create(:user, email: 'nancy@example.com')

        bob_site = FactoryBot.create(:site, name: 'bob site')
        nancy_site = FactoryBot.create(:site, name: 'nancy site')
        bob_and_nancy_site = FactoryBot.create(:site, name: 'bob and nancy site')

        SiteMember.create(user: user_bob, site: bob_site)
        SiteMember.create(user: user_nancy, site: nancy_site)
        SiteMember.create(user: user_bob, site: bob_and_nancy_site)
        SiteMember.create(user: user_nancy, site: bob_and_nancy_site)

        expect(user_bob.sites.to_ary).to eq [bob_site, bob_and_nancy_site]
      end
    end
  end
end
