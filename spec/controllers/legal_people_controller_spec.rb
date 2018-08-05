require 'rails_helper'

RSpec.describe Api::V1::LegalPeopleController, type: :controller do
  before { @request.host = 'api.example.com' }
  before do
    headers = { 'Accept' => Mime[:json], 'Content-Type' => Mime[:json].to_s }
    request.headers.merge! headers
  end

  let!(:legal_person) { FactoryGirl.create(:legal_person) }

  describe 'GET #index' do
    before { get :index, params: { format: :json } }

    it 'success' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    context 'valid id' do
      before { get :show, params: { id: legal_person.to_param } }

      it 'success' do
        expect(response).to have_http_status(200)
      end
    end
  end
end