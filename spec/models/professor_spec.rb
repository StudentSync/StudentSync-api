require 'rails_helper'

RSpec.describe Professor, type: :model do
  let(:professor) { create(:professor) }

  it "is valid with valid attributes" do
    expect(professor).to be_valid
  end

  it "is not valid without an name" do
    professor.name = nil
    expect(professor).to_not be_valid
  end

  it "is not valid without an user" do
    professor.user = nil
    expect(professor).to_not be_valid
  end

  it "is not valid with a duplicate user" do
    duplicate_user = build(:professor, user: professor.user)

    expect(duplicate_user).to_not be_valid
  end
end
