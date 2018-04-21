FactoryBot.define do
  factory :user do
    email "FactoryBot@example.com"
    after(:build) { |u| u.password_confirmation = u.password = 'Password7!' }
  end
end
