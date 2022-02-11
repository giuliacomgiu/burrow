FactoryBot.define do
  factory :lease do
    association :bookcopy
    association :lessee, factory: :person, first_name: 'owner', last_name: 'last'
  end
end