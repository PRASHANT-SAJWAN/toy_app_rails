FactoryBot.define do

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password {"pass"}
  end
end
