FactoryBot.define do
  factory :bookcopy do
    association :owner, factory: :person
    association :book
  end
end
