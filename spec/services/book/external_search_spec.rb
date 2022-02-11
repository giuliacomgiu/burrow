require 'rails_helper'

describe Books::ExternalSearch do
  describe '#run' do
    context 'when books are found' do
      let(:options) { { query: 'generic search words' } }
      let(:instance) { described_class.new(options) }
      let(:result) { instance.run }

      it 'returns valid hash' do
        expect(result.keys).to contain_exactly(:items, :total_items)
        expect(result[:items]).to be_an(Array)
        expect(result[:items].first.keys).to contain_exactly(:title, :authors, :publisher, :published_date, :isbn)
      end
    end

    xcontext 'when books werent found'
  end
end
