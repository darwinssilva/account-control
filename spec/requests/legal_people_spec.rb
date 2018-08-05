require 'rails_helper'

RSpec.describe "LegalPeople", type: :request do
  describe "GET /legal_people" do
    it "works! (now write some real specs)" do
      get legal_people_path
      expect(response).to have_http_status(200)
    end
  end
end
