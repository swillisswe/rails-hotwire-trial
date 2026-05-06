require "rails_helper"

RSpec.describe Like, type: :model do
  it "is valid with a user and photo" do
    expect(build(:like)).to be_valid
  end

  it "prevents a user from liking the same photo twice" do
    user  = create(:user)
    photo = create(:photo)
    create(:like, user: user, photo: photo)
    expect(build(:like, user: user, photo: photo)).not_to be_valid
  end

  it "enforces uniqueness at the database level" do
    user  = create(:user)
    photo = create(:photo)
    Like.create!(user: user, photo: photo)
    duplicate = Like.new(user: user, photo: photo)
    expect { duplicate.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it "destroys likes when the associated user is destroyed" do
    like = create(:like)
    expect { like.user.destroy }.to change(Like, :count).by(-1)
  end
end
