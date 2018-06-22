# spec/requests/organizations_spec.rb
require 'rails_helper'

RSpec.describe 'Organizations API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:organizations) { create_list(:organization, 10, created_by: user.id) }
  let(:organization_id) { organizations.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /organizations
  describe 'GET /organizations' do
    # make HTTP get request before each example
    before { get '/organizations', params: {}, headers: headers }

    it 'returns organizations' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /organizations/:id
  describe 'GET /organizations/:id' do
    before { get "/organizations/#{organization_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the organization' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(organization_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:organization_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Organization with 'id'=100/)
      end
    end
  end

  # Test suite for POST /organizations
  describe 'POST /organizations' do
    # valid payload
    let(:valid_attributes) do
      { name: 'Pet Rescue Name', line1: '123 Anystreet Street', city: 'Anywhere', state: 'CA', zipcode: '12345', phone: '123.456.7890', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/organizations', params: valid_attributes, headers: headers }

      it 'creates a organization' do
        expect(json['name']).to eq('Pet Rescue Name')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/organizations', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Name can't be blank, Line1 can't be blank, City can't be blank, State can't be blank, Zipcode can't be blank, Phone can't be blank/)
      end
    end
  end

  # Test suite for PUT /organizations/:id
  describe 'PUT /organizations/:id' do
    let(:valid_attributes) { { name: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/organizations/#{organization_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /organizations/:id
  describe 'DELETE /organizations/:id' do
    before { delete "/organizations/#{organization_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
