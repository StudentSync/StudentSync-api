require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { FactoryBot.create(:student) }

  it "is valid with valid attributes" do
    expect(student).to be_valid
  end

  it "is not valid without an name" do
    student.name = nil
    expect(student).to_not be_valid
  end

  it "is not valid without an user" do
    student.user = nil
    expect(student).to_not be_valid
  end

  it "is not valid without an course" do
    student.course = nil
    expect(student).to_not be_valid
  end

  it "is not valid without an semester" do
    student.semester = nil
    expect(student).to_not be_valid
  end

  it "is not valid when semester exceeds character limit" do
    student.semester = FFaker::Lorem.characters(2)
    expect(student).to_not be_valid
  end

  it "is not valid with a duplicate user" do
    duplicate_user = FactoryBot.build(:student, user: student.user)

    expect(duplicate_user).to_not be_valid
  end
end
