# frozen_string_literal: true

FactoryBot.define do
  factory :notification_channel do
    type { '' }
    enabled { false }
    site_member { nil }
  end
end
