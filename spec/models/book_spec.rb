# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'columns' do
    it { expect(described_class.column_names).to match_array(%w[id title author publisher isbn created_at updated_at]) }
    it { should have_db_index(:isbn) }
  end

  describe 'association' do
    it { should have_many(:bookcopies) }
    it { should have_many(:owners) }
  end

  describe 'validations' do
    subject { build(:book) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:publisher) }
    it { should validate_presence_of(:isbn) }
    it { should validate_uniqueness_of(:isbn) }
  end
end
