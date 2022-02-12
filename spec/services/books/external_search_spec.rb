require 'rails_helper'
require 'webmock/rspec'

describe Books::ExternalSearch do
  describe '#run' do
    let(:instance) { described_class.new(options) }
    let(:result) { instance.run }

    context 'when books are found' do
      let(:options) { { query: 'the silmarillion' } }
      let(:response_body) { File.open('./spec/fixtures/found_ext_search.json') }

      it 'returns valid hash with items' do
        stub_request(:get, 'https://www.googleapis.com/books/v1/volumes/?q=the+silmarillion&key=AIzaSyD_zn1FDbq1UbytVq929LWb4DJQUjhgkVE')
          .to_return(body: response_body, status: 200)
        expect(result.keys).to contain_exactly(:items, :total_items)
        expect(result[:items]).to be_an(Array)
        expect(result[:items].first.keys).to contain_exactly(:title, :authors, :publisher, :published_date, :isbn)
      end
    end

    context 'when books werent found' do
      let(:options) { { query: 'n0n3x1st4nt!' } }

      it 'returns valid hash without items' do
        stub_request(:get, 'https://www.googleapis.com/books/v1/volumes/?q=n0n3x1st4nt!&key=AIzaSyD_zn1FDbq1UbytVq929LWb4DJQUjhgkVE')
          .to_return(body: '{ "kind": "books#volumes", "totalItems": 0 }', status: 200)
        expect(result.keys).to contain_exactly(:items, :total_items)
        expect(result[:items]).to be_empty
        expect(result[:total_items]).to eq 0
      end
    end

    context 'with invalid API key' do
      let(:options) { { query: 'the silmarillion' } }

      it 'returns valid hash without items' do
        allow(instance).to receive(:authentication_key).and_return(nil)
        stub_request(:get, 'https://www.googleapis.com/books/v1/volumes/?q=the+silmarillion')
          .to_return(body: '{ "kind": "books#volumes", "totalItems": 0 }', status: 200)
        expect(result.keys).to contain_exactly(:items, :total_items)
        expect(result[:items]).to be_empty
        expect(result[:total_items]).to eq 0
      end
    end
  end
end
