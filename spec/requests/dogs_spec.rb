require 'rails_helper'

RSpec.describe 'Dogs API' do
  # Initialize the test data
  let!(:organization) { create(:organization) }
  let!(:dogs) { create_list(:dog, 20, organization_id: organization.id) }
  let(:organization_id) { organization.id }
  let(:id) { dogs.first.id }

  # Test suite for GET /organizations/:organization_id/dogs
  describe 'GET /organizations/:organization_id/dogs' do
    before { get "/organizations/#{organization_id}/dogs" }

    context 'when organization exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all organization dogs' do
        expect(json.size).to eq(20)
      end
    end

    context 'when organization does not exist' do
      let(:organization_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      # it 'returns a not found message' do
      #   expect(response.body).to match(/Couldn't find Dog/)
      # end
    end
  end

  # Test suite for GET /organizations/:organization_id/dogs/:id
  describe 'GET /organizations/:organization_id/dogs/:id' do
    before { get "/organizations/#{organization_id}/dogs/#{id}" }

    context 'when organization dog exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the dog' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when organization dog does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      # it 'returns a not found message' do
      #   expect(response.body).to match(/Couldn't find Organization with 'id'=0/)
      # end
    end
  end

  # Test suite for PUT /organizations/:organization_id/dogs
  describe 'POST /organizations/:organization_id/dogs' do
    let(:valid_attributes) { { name: 'Fido' } }

    context 'when request attributes are valid' do
      before { post "/organizations/#{organization_id}/dogs", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/organizations/#{organization_id}/dogs", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /organizations/:organization_id/dogs/:id
  describe 'PUT /organizations/:organization_id/dogs/:id' do
    let(:valid_attributes) { { name: 'Rufus' } }

    before { put "/organizations/#{organization_id}/dogs/#{id}", params: valid_attributes }

    context 'when dog exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the dog' do
        updated_dog = Dog.find(id)
        expect(updated_dog.name).to match(/Rufus/)
      end
    end

    context 'when the dog does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      # it 'returns a not found message' do
      #   expect(response.body).to match(/Couldn't find Dog/)
      # end
    end
  end

  # Test suite for DELETE /organizations/:id
  describe 'DELETE /organizations/:id' do
    before { delete "/organizations/#{organization_id}/dogs/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
