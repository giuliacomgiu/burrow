# frozen_string_literal: true

class Bookcopy < ApplicationRecord
  # A bookcase is a group of copies!
  # If the need arises, create separate tables
  # for bookcases and copies
  belongs_to :book
  belongs_to :owner, class_name: 'Person', foreign_key: 'owner_id'

  validates :book_id, presence: true
  validates :owner_id, presence: true
end
