require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:photo) { create(:photo) }

  before { post session_path, params: { email: user.email, password: "password" } }

  let(:turbo_headers) { { "Accept" => "text/vnd.turbo-stream.html" } }

  describe "POST /photos/:photo_id/like" do
    it "creates a like and returns a turbo stream" do
      post photo_like_path(photo), headers: turbo_headers
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(photo.likes.count).to eq(1)
    end

    it "is idempotent" do
      create(:like, user: user, photo: photo)
      post photo_like_path(photo), headers: turbo_headers
      expect(photo.likes.where(user: user).count).to eq(1)
    end
  end

  describe "DELETE /photos/:photo_id/like" do
    it "destroys the like and returns a turbo stream" do
      create(:like, user: user, photo: photo)
      delete photo_like_path(photo), headers: turbo_headers
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(photo.likes.count).to eq(0)
    end
  end
end
