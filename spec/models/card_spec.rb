require 'rails_helper'

describe :card do
  it "should have valid factory" do
    expect(build(:card)).to be_valid
  end

  describe "validation tests" do
    subject { build(:card) }

    it { should validate_presence_of :original_text }
    it { should validate_presence_of :translated_text }

    { identity: "rr", upcase: "RR" }.each do |k, v|
      it "validate texts #{k}" do
        card = build(:card, original_text: "rr",translated_text: v)
        expect(card.valid?).to be_falsey
        expect(card.errors[:texts]).to include 'must be different'
      end
    end
  end

  describe "methods tests" do
    let(:card) { create(:card) }

    it "touch review date!" do
      time = card.review_date
      card.send(:touch_review_date!)
      expect(card.review_date).not_to eq(time)
    end

    context "#check answer" do
      it "correct answers" do
        ['original text', 'OriGinal teXt', 'Original teXt  '].each do |answer|
          result = card.check_answer(answer)
          expect(result.success?).to be_truthy
        end
      end

      it "wrong answer" do
        result = card.check_answer('wrong text')
        expect(result.success?).to be_falsey
      end
    end

    it "gives cards to review" do
      10.times do |i|
        create(:card_for_review)
      end
      expect(Card.review.size).to eq(10)
    end
  end

  describe "before validation" do
    it "set review date to new object on create" do
      card = build(:card)
      expect(card.review_date).to be_nil
      card.valid?
      expect(card.review_date).to be_truthy
    end

    it "remove whitespace on create" do
      card = create(:card, original_text: '   d', translated_text: 'h   ')
      expect(card.original_text).to eq('d')
      expect(card.translated_text).to eq('h')
    end

    it "remove whitespace on update" do
      card = create(:card)
      card.update(original_text: '   d', translated_text: 'h   ')
      expect(card.original_text).to eq('d')
      expect(card.translated_text).to eq('h')
    end
  end
end
