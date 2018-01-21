FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    phones { build_list(:phone, 3) }
  end
end
