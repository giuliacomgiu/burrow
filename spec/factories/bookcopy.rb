# frozen_string_literal: true

FactoryBot.define do
  factory :bookcopy do
    association :owner, factory: :person
    association :book
  end
end
