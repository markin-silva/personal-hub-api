require "rails_helper"

RSpec.describe "Api::V1::Health", type: :request do
  describe "GET /api/v1/health" do
    it "returns health status successfully" do
      get "/api/v1/health"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq({
        "status" => "ok",
        "database" => "connected"
      })
    end

    it "allows CORS requests from allowed origins" do
      get "/api/v1/health", headers: { "Origin" => "http://localhost:5173" }

      expect(response).to have_http_status(:ok)
      expect(response.headers["Access-Control-Allow-Origin"]).to eq("http://localhost:5173")
    end
  end
end
