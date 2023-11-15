require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is not valid with a short password" do
    user.password = FFaker::Lorem.characters(5)
    expect(user).to_not be_valid
  end

  it "is valid with a password of minimum length" do
    user.password = FFaker::Lorem.characters(6)
    expect(user).to be_valid
  end

  it "is not valid with a duplicate email" do
    duplicate_email = build(:user, email: user.email)
    expect(duplicate_email).to_not be_valid
  end
end
