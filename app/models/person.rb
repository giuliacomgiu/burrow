class Person < ApplicationRecord
  has_many :bookcopies, dependent: :destroy, foreign_key: 'owner_id'
  has_many :books, through: :bookcopies, inverse_of: :owners
  has_many :leases, foreign_key: 'lessee_id'

  validates :first_name, presence: true, format: { with: /[a-zA-Z]/ } # todo: regex for line start and end
  validates :last_name, presence: true, format: { with: /[a-zA-Z]/ } # todo: regex for line start and end
end
