FactoryBot.define do
  factory :scheduled_chore do
    due {"2018-05-20 08:45:25"}
    chore {nil}
    site {nil}
  end
end
