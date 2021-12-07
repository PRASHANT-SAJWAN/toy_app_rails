FactoryBot.define do

  factory :post do
    content { Faker::Lorem.sentence(word_count: 8) }
    user_id {"joe@gmail.com"}
  end
end
