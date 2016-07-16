FactoryGirl.define do
  factory :deck do
    association :user, factory: :user
    title 'deck title'
    description 'deck description'
  end
end
