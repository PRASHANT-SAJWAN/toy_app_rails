FactoryBot.define do

  factory :user do
    name {"Joe"}
    email {"joe@gmail.com"}
    password {"pass"}
  end

  factory :random_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password {"pass"}
  end
end
