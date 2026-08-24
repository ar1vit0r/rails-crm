FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    company { Faker::Company.name }
    position { Faker::Job.title }
    status { "lead" }
    user
  end
end
