# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :request do
  describe 'GET /index' do
    before { get '/people' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /new' do
    before { get '/people/new' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'POST /create' do
    let(:params) { { person: { first_name: 'Abigail', last_name: 'Severo' } } }
    before { post '/people', params: params }

    it { expect(response).to redirect_to people_path }
    it { expect(described_class.count).to eq 1 }
  end

  describe 'GET /people/id' do
    let(:person) { create(:person) }
    before { get "/people/#{person.id}" }

    it { expect(response).to have_http_status :ok }
  end
end
