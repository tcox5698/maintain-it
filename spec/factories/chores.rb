FactoryBot.define do
  factory :chore do
    name {"FactoryChoreName"}
    description {"FactoryChoreDescription"}
    schedule {"daily"}
    site 
  end
end
