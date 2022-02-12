require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "Books", type: :request do
  describe "GET /books/search" do
    let(:response_body) { File.open('./spec/fixtures/found_ext_search.json') }

    context 'with params' do
      it 'redirects to search result page' do
        stub_request(:get, 'https://www.googleapis.com/books/v1/volumes/?q=the+silmarillion&key=AIzaSyD_zn1FDbq1UbytVq929LWb4DJQUjhgkVE')
          .to_return(body: response_body, status: 200)
        get '/books/search', params: { query: 'the silmarillion' }
        expect(response).to redirect_to '/books/search/the+silmarillion'
      end
    end

    context 'without params' do
      it 'renders search view' do
        get '/books/search'
        expect(response).to have_http_status :ok
      end
    end
  end
end
