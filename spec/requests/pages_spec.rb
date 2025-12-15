require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /guide" do
    it "returns http success" do
      get "/pages/guide"
      expect(response).to have_http_status(:success)
    end
  end

end
