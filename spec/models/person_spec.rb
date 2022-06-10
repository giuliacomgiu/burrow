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
    it { should allow_value('ana').for(:first_name) }
    it { should allow_value('ana maria').for(:first_name) }
    it { should allow_value('silva').for(:last_name) }
    it { should allow_value('silva camargo').for(:last_name) }
    it { should_not allow_value('123').for(:first_name) }
    it { should_not allow_value('123').for(:last_name) }
  end

  describe 'callbacks' do
    describe '#before_save' do
      let(:person) { build(:person, first_name: 'ana maria', last_name: 'da silva') }
      before { person.save }

      it { expect(person.reload).to be_persisted }
      it { expect(person.first_name).to eq 'Ana Maria' }
      it { expect(person.last_name).to eq 'Da Silva' }
    end
  end
end
