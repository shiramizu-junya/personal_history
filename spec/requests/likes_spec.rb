require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/likes/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/likes/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
