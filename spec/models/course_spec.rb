require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { create(:course) }

  it "is valid with valid attributes" do
    expect(course).to be_valid
  end

  it "is not valid without an name" do
    course.name = nil
    expect(course).to_not be_valid
  end

  it "is not valid with a duplicate name" do
    duplicate_course = build(:course, name: course.name)

    expect(duplicate_course).to_not be_valid
  end
  
end
