# frozen_string_literal: true

class Person < ApplicationRecord
  has_many :bookcopies, dependent: :destroy, foreign_key: 'owner_id'
  has_many :books, through: :bookcopies, inverse_of: :owners
  has_many :leases, foreign_key: 'lessee_id'

  validates :first_name, presence: true, format: { with: /\A[a-zA-Z ]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z ]+\z/ }

  before_save { |person| person.first_name.strip.split.map(&:capitalize).join(' ') }
  before_save { |person| person.last_name.strip.split.map(&:capitalize).join(' ') }
end
