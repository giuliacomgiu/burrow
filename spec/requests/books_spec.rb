# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Books', type: :request do
  describe 'GET /books/search_result' do
    context 'with params' do
      let(:response_body) { File.open('./spec/fixtures/found_ext_search.json') }

      it 'redirects to search result page' do
        stub_request(:get, 'https://www.googleapis.com/books/v1/volumes/?q=the+silmarillion&key=AIzaSyD_zn1FDbq1UbytVq929LWb4DJQUjhgkVE')
          .to_return(body: response_body, status: 200)
        get '/books/search_result', params: { query: 'the silmarillion' }
        expect(response).to have_http_status :ok
      end
    end

    context 'without params' do
      it 'renders search view' do
        stub_request(:get, 'https://www.googleapis.com/books/v1/volumes/?key=AIzaSyD_zn1FDbq1UbytVq929LWb4DJQUjhgkVE&q=')
          .to_return(body: '{ "kind": "books#volumes", "totalItems": 0 }', status: 200)
        get '/books/search_result'
        expect(response).to have_http_status :ok
      end
    end
  end
end
