require "rails_helper"

RSpec.describe "Authentication", type: :request do
  it "redirects unauthenticated users to sign in" do
    get root_path
    expect(response).to redirect_to(new_session_path)
  end

  it "allows authenticated users to access the gallery" do
    user = create(:user)
    post session_path, params: { email: user.email, password: "password" }
    get root_path
    expect(response).to have_http_status(:ok)
  end
end
