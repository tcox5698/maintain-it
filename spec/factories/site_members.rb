# frozen_string_literal: true

FactoryBot.define do
  factory :site_member do
    nick_name { 'FactoryBotSiteMember' }
    site
    user
  end
end
