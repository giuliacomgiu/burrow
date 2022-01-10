class Lease < ApplicationRecord
  belongs_to :bookcopy
  belongs_to :lessee, class_name: 'Person'
  has_one :owner, through: :bookcopy
end