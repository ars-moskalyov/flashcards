require 'rails_helper'

describe :card do

  it "should have valid factory" do
    expect(build(:card)).to be_valid
  end

  describe "validation tests" do
    subject { build(:card) }

    it { should validate_presence_of :original_text }
    it { should validate_presence_of :translated_text }

    { identity: "rr", whitespaces: "rr\n", caps: "RR" }.each do |k, v|
      it "validate texts #{k}" do
        card = build(:card, original_text: "rr",translated_text: v)
        expect(card.valid?).to be_falsey
        expect(card.errors[:texts]).to include 'must be different'
      end
    end
  end

  describe "methods tests" do
    let(:card) { create(:card) }

    # !!! нужно ли его тестировать?  или совместить с check answer
    it "touch new review date" do
      time = card.review_date
      card.send(:touch_review_date!)
      expect(card.review_date).not_to eq(time)
    end

    it "check right answer" do
      result = card.check_answer('original text')
      expect(result.success?).to be_truthy
    end

    it "check wrong answer" do
      result = card.check_answer('wrong text')
      expect(result.success?).to be_falsey
    end

    it "gives cards to review" do
      date = Time.now
      10.times do |i|
        c = FactoryGirl.create(:card)
        c.update(review_date: date)
      end
      expect(Card.review.first.review_date).to eq(date)
      expect(Card.review.size).to eq(10)
    end

    it "set review date to new object on create" do
      card = build(:card)
      expect(card.review_date).to be_nil
      card.save
      expect(card.review_date).to be_truthy
    end    
  end
end
