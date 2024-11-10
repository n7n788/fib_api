require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "#hello" do
    it 'returns http success' do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end