require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "GET /session/new" do
    it "renders the sign in page" do
      get new_session_path
      expect(response).to have_http_status(:ok)
    end

    it "redirects to root if already signed in" do
      post session_path, params: { email: user.email, password: "password" }
      get new_session_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST /session" do
    it "signs in with valid credentials and redirects to root" do
      post session_path, params: { email: user.email, password: "password" }
      expect(response).to redirect_to(root_path)
    end

    it "sets a signed in notice" do
      post session_path, params: { email: user.email, password: "password" }
      expect(flash[:notice]).to eq("Signed in successfully.")
    end

    it "rejects invalid credentials" do
      post session_path, params: { email: user.email, password: "wrong" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /session" do
    it "signs out and redirects to sign in" do
      post session_path, params: { email: user.email, password: "password" }
      delete session_path
      expect(response).to redirect_to(new_session_path)
    end

    it "sets a signed out notice" do
      post session_path, params: { email: user.email, password: "password" }
      delete session_path
      expect(flash[:notice]).to eq("Signed out successfully.")
    end
  end
end
