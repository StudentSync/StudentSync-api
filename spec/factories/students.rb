FactoryBot.define do
  factory :student do
    user { nil }
    course { nil }
    name { "MyString" }
    semester { "MyString" }
    schedule_availability { "MyString" }
  end
end
