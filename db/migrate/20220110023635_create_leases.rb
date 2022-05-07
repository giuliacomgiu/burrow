# frozen_string_literal: true

class CreateLeases < ActiveRecord::Migration[6.1]
  def change
    create_table :leases do |t|
      t.references :lessee, null: false, foreign_key: { to_table: :people }
      t.references :bookcopy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
