require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  before { @request.host = 'api.example.com' }
  before do
    headers = { 'Accept' => Mime[:json], 'Content-Type' => Mime[:json].to_s }
    request.headers.merge! headers
  end

  let!(:physical_account) { FactoryGirl.create(:account, :physical_person) }
  let!(:legal_account) { FactoryGirl.create(:account, :legal_person) }

  describe 'GET #index' do
    before { get :index, params: { format: :json } }

    it 'success' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    context 'valid id physical_account' do
      before { get :show, params: { id: physical_account.to_param } }

      it 'success' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #show' do
    context 'valid id legal_account' do
      before { get :show, params: { id: legal_account.to_param } }

      it 'success' do
        expect(response).to have_http_status(200)
      end
    end
  end
end