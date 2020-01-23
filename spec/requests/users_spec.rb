require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  let!(:users) { create_list(:user, 20) }
  let(:user_id) { users.first.id }

  # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) { { name: 'Tiago Ferreira', email: 'tiferreira12@gmail.com', password: '123123' } }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(json).to have_key('user')
        expect(json['user']).to have_key('name')
        expect(json['user']['name']).to eq('Tiago Ferreira')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { name: 'Invalid params', email: 'missing-password@gmail.com' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Password can't be blank/)
      end
    end
  end
end
