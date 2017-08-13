FactoryGirl.define do
  factory :user do
    email "factorygirl@example.com"
    after(:build) { |u| u.password_confirmation = u.password = 'Password7!' }
  end
end
