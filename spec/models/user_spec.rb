require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(email: "test@example.com", password: "password123")
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a duplicate email" do
      User.create!(email: "test@example.com", password: "password123")
      user = User.new(email: "test@example.com", password: "password123")
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end
end
