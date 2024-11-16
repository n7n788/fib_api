# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Fibonaccis', type: :request do
  describe '#GET /fib' do
    context 'when params n is 1' do
      it 'returns http 200 status' do
        get '/fib', params: { n: 1 }
        expect(response).to have_http_status(200)
      end

      it 'returns json response' do
        get '/fib', params: { n: 1 }
        response_body = JSON.parse(response.body)
        expect(response_body['result']).to eq(1)
      end
    end

    context 'when params n is zero' do
      it 'returns http 400 status' do
        get '/fib', params: { n: 0 }
        expect(response).to have_http_status(400)
      end

      it 'returns json response' do
        get '/fib', params: { n: 0 }
        response_body = JSON.parse(response.body)
        aggregate_failures do
          expect(response_body['status']).to eq 400
          expect(response_body['message']).to eq 'Bad request.'
        end
      end
    end

    context 'when params n is not integer' do
      it 'returns http 400 status' do
        get '/fib', params: { n: 'a' }
        expect(response).to have_http_status(400)
      end

      it 'returns json response' do
        get '/fib', params: { n: 'a' }
        response_body = JSON.parse(response.body)
        aggregate_failures do
          expect(response_body['status']).to eq 400
          expect(response_body['message']).to eq 'Bad request.'
        end
      end
    end
  end
end
