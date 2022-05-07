# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_110_023_635) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bookcopies', force: :cascade do |t|
    t.bigint 'owner_id', null: false
    t.bigint 'book_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['book_id'], name: 'index_bookcopies_on_book_id'
    t.index ['owner_id'], name: 'index_bookcopies_on_owner_id'
  end

  create_table 'books', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'author', null: false
    t.string 'isbn', null: false
    t.string 'publisher', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['isbn'], name: 'index_books_on_isbn'
  end

  create_table 'leases', force: :cascade do |t|
    t.bigint 'lessee_id', null: false
    t.bigint 'bookcopy_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['bookcopy_id'], name: 'index_leases_on_bookcopy_id'
    t.index ['lessee_id'], name: 'index_leases_on_lessee_id'
  end

  create_table 'people', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'bookcopies', 'books'
  add_foreign_key 'bookcopies', 'people', column: 'owner_id'
  add_foreign_key 'leases', 'bookcopies'
  add_foreign_key 'leases', 'people', column: 'lessee_id'
end
