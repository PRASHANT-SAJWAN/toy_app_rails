FactoryBot.define do

  factory :user do
    email {'test@test.com'}
    name {'testuser'}
    password {'userpass'}
  end

  factory :random_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password {"pass"}
  end
end
