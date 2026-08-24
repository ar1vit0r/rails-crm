FactoryBot.define do
  factory :lead do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    status { "new" }
    value { Faker::Commerce.price(range: 1000..100000.0) }
    priority { "medium" }
    contact
    user
  end
end
