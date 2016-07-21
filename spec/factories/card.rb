FactoryGirl.define do
  factory :card do
    association :deck, factory: :deck
    original_text "original text"
    translated_text  "translated text"
    check 1
    effort 0
    image Rails.root.join("spec/support/files/card.png").open
  end
end
