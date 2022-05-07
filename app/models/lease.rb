# frozen_string_literal: true

class Lease < ApplicationRecord
  belongs_to :bookcopy
  belongs_to :lessee, class_name: 'Person'
  has_one :owner, through: :bookcopy

  validates :lessee, presence: true
  validates :bookcopy, presence: true
end
