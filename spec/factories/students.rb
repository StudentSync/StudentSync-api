FactoryBot.define do
  factory :student do
    user
    course
    name { FFaker::Name.name }
    semester { FFaker::Lorem.characters(1) }
  end
end
