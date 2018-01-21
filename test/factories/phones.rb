FactoryBot.define do
  factory :phone do
    number { Faker::Number.number(10) }
  end
end
