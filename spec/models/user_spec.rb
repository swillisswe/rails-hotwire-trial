require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with name, email, and password" do
    expect(build(:user)).to be_valid
  end

  it "requires name" do
    expect(build(:user, name: nil)).not_to be_valid
  end

  it "requires email" do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it "requires unique email" do
    create(:user, email: "test@example.com")
    expect(build(:user, email: "test@example.com")).not_to be_valid
  end

  it "requires a valid email format" do
    expect(build(:user, email: "notanemail")).not_to be_valid
  end

  it "downcases email before saving" do
    user = create(:user, email: "TEST@EXAMPLE.COM")
    expect(user.reload.email).to eq("test@example.com")
  end
end
