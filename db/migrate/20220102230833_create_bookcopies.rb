class CreateBookcopies < ActiveRecord::Migration[6.1]
  def change
    create_table :bookcopies do |t|
      t.belongs_to :owner, foreign_key: { to_table: :people }, null: false
      t.belongs_to :book, foreign_key: true, null: false

      t.timestamps
    end
  end
end
