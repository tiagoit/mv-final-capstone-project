require 'rails_helper'

RSpec.describe 'Favourites API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:favourite) { user.favourites.create(attributes_for(:favourite)) }

  # Test suite for POST /favourites
  describe 'POST /favourites' do
    # valid payload
    let(:valid_attributes) { { id: 1 } }

    # auth headers
    let(:token) { JsonWebToken.encode(user_id: user.id) }
    let(:headers) { { 'Authorization': "Bearer #{token}" } }

    context 'when the user is not authenticated' do
      before { post '/favourites', params: valid_attributes }

      it 'block not auth requests' do
        expect(json).to have_key('errors')
        expect(json['errors']).to eq('Nil JSON web token')
      end
    end

    context 'when the request is valid' do
      before { post '/favourites', params: valid_attributes, headers: headers }

      it 'expects token to be defined' do
        expect(token).not_to be_nil
      end

      it 'creates a favourite' do
        expect(json).to have_key('provider_id')
        expect(json['provider_id']).to eq("1")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/favourites', params: { provider_id: 1 }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Provider can't be blank/)
      end
    end
  end
end
