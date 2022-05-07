# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'columns' do
    it { expect(described_class.column_names).to match_array(%w[id first_name last_name created_at updated_at]) }
  end

  describe 'association' do
    it { should have_many(:bookcopies).dependent(:destroy) }
    it { should have_many(:books) }
    it { should have_many(:leases) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should_not allow_value('123').for(:first_name) }
    it { should_not allow_value('123').for(:last_name) }
  end
end
