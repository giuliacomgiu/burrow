# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookcopy, type: :model do
  describe 'columns' do
    it { expect(described_class.column_names).to match_array(%w[id owner_id book_id created_at updated_at]) }
    it { should have_db_index(:owner_id) }
    it { should have_db_index(:book_id) }
  end

  describe 'associations' do
    it { should belong_to(:owner) }
    it { should belong_to(:book) }
  end

  describe 'validations' do
    it { should validate_presence_of(:owner_id) }
    it { should validate_presence_of(:book_id) }
  end
end
