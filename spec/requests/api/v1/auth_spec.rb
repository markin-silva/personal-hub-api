require "rails_helper"

RSpec.describe "Api::V1::Auth", type: :request do
  describe "POST /api/v1/users" do
    it "creates a new user successfully" do
      user_params = {
        user: {
          email: "user@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }

      post "/api/v1/users", params: user_params

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["message"]).to eq("Signed up successfully.")
    end
  end

  describe "POST /api/v1/users/sign_in" do
    it "authenticates user and returns JWT token in headers" do
      User.create!(email: "user@example.com", password: "password123")

      user_params = {
        user: {
          email: "user@example.com",
          password: "password123"
        }
      }

      post "/api/v1/users/sign_in", params: user_params, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:ok)
      expect(response.headers["Authorization"]).to be_present
      expect(response.parsed_body["message"]).to eq("Logged in successfully.")
    end
  end
end
