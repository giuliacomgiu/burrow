# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'Cahier D\'un Retour Au Pays Natal' }
    author { 'Aimé Cesaire' }
    isbn { 'a8531413559' }
    publisher { 'EDUSP' }
  end
end
