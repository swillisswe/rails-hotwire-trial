require "rails_helper"

RSpec.describe Photo, type: :model do
  it "is valid with required fields" do
    expect(build(:photo)).to be_valid
  end

  it "requires photographer" do
    expect(build(:photo, photographer: nil)).not_to be_valid
  end

  it "requires image_url" do
    expect(build(:photo, image_url: nil)).not_to be_valid
  end

  it "requires source_url" do
    expect(build(:photo, source_url: nil)).not_to be_valid
  end

  describe "#liked_by?" do
    let(:user)  { create(:user) }
    let(:photo) { create(:photo) }

    it "returns true when the user has liked the photo" do
      create(:like, user: user, photo: photo)
      expect(photo.liked_by?(user)).to be true
    end

    it "returns false when the user has not liked the photo" do
      expect(photo.liked_by?(user)).to be false
    end

    it "returns false when user is nil" do
      expect(photo.liked_by?(nil)).to be false
    end
  end

  it "destroys likes when photo is destroyed" do
    photo = create(:photo)
    create(:like, photo: photo)
    expect { photo.destroy }.to change(Like, :count).by(-1)
  end
end
