require 'rails_helper'

 RSpec.describe Api::V1::PhysicalPeopleController, type: :controller do

  before { @request.host = 'api.example.com' }
  before do
    headers = { 'Accept' => Mime[:json], 'Content-Type' => Mime[:json].to_s }
    request.headers.merge! headers
  end

  let!(:physical_person) { FactoryGirl.create(:physical_person) }

   describe 'GET #index' do
    before { get :index, params: { format: :json } }
     it 'retornar status 200 success' do
      expect(response).to have_http_status(200)
    end
  end

   describe 'GET #show' do
    context 'id válido' do
      before { get :show, params: { id: physical_person.to_param } }
       it 'retornar status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end 