FactoryBot.define do
  factory :professor do
    user { nil }
    name { "MyString" }
    academic_degree { "MyString" }
    description { "MyText" }
  end
end
