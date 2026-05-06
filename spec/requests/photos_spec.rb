require "rails_helper"

RSpec.describe "Photos", type: :request do
  let(:user) { create(:user) }

  before { post session_path, params: { email: user.email, password: "password" } }

  it "renders the gallery with photo content" do
    photo = create(:photo, photographer: "Ansel Adams")
    get photos_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Ansel Adams")
  end
end
