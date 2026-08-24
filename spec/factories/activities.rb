FactoryBot.define do
  factory :activity do
    kind { "note" }
    body { Faker::Lorem.paragraph }
    performed_at { Faker::Time.between(from: 30.days.ago, to: Time.current) }
    contact
    user
  end
end
