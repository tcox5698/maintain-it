# frozen_string_literal: true

FactoryBot.define do
  factory :chore do
    name { 'FactoryChoreName' }
    description { 'FactoryChoreDescription' }
    schedule { 'daily' }
    site
  end
end
