FactoryBot.define do
  factory :professor do
    user
    name { FFaker::Name.name }
  end
end
