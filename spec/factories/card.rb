FactoryGirl.define do
  factory :card do
    original_text "original text"
    translated_text  "translated text"
  end

  factory :card_for_review, class: "Card" do
    original_text "original text"
    translated_text  "translated text"

    after(:create) do |card|
      card.review_date = Time.now
      card.save
    end
  end

end