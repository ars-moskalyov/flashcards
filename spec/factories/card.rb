FactoryGirl.define do
  factory :card do
    association :user, factory: :user
    original_text "original text"
    translated_text  "translated text"
    image Rails.root.join("spec/support/files/card.png").open
  end

  factory :card_for_review, class: "Card" do
    association :user, factory: :user
    original_text "original text"
    translated_text  "translated text"
    image Rails.root.join("spec/support/files/card.png").open

    after(:create) do |card|
      card.review_date = Time.now
      card.save
    end
  end
end
