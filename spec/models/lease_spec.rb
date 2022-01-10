require 'rails_helper'

RSpec.describe Lease, type: :model do
  describe 'columns' do
    it { expect(described_class.column_names).to match_array(%w(id bookcopy_id lessee_id created_at updated_at)) }
    it { should have_db_index(:bookcopy_id) }
    it { should have_db_index(:lessee_id) }
  end

  describe 'associations' do
    it { should belong_to(:bookcopy) }
    it { should belong_to(:lessee) }
    it { should have_one(:owner) }
  end
end