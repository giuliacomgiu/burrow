class Book < ApplicationRecord
  has_many :bookcopies
  has_many :owners, through: :bookcopies, inverse_of: :books

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :publisher, presence: true
end
