require 'rails_helper'

RSpec.describe "Tracks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/tracks/index"
      expect(response).to have_http_status(:success)
    end
  end

end
