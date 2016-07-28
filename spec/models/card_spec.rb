require 'rails_helper'

RSpec.describe Card, type: :model do
  it 'should have valid factory' do
    expect(build(:card)).to be_valid
  end

  describe 'associations tests' do
    it { should belong_to :deck }
    it { should have_one :user }
  end

  describe 'validation tests' do
    it { should validate_presence_of :original_text }
    it { should validate_presence_of :translated_text }
    it { should validate_presence_of :deck }
    it { should validate_inclusion_of(:check).in_range(1..5) }
    it { should validate_inclusion_of(:effort).in_range(0..2) }

    { identity: 'rr', upcase: 'RR' }.each do |k, v|
      it "validate texts #{k}" do
        card = build(:card, original_text: 'rr',translated_text: v)
        expect(card.valid?).to be_falsey
        expect(card.errors[:texts]).to include t('activerecord.errors.messages.different_texts')
      end
    end
  end

  describe 'methods tests' do
    let(:card) { create(:card) }

    it '.review' do
      10.times do |i|
        create(:card)
      end
      expect(Card.review.size).to eq(10)
    end
  end

  describe 'before validation' do
    it 'set review date to new object on create' do
      card = build(:card)
      expect(card.review_date).to be_nil
      card.valid?
      expect(card.review_date).to be_truthy
    end

    it 'remove whitespace on create' do
      card = create(:card, original_text: '   d', translated_text: 'h   ')
      expect(card.original_text).to eq('d')
      expect(card.translated_text).to eq('h')
    end

    it 'remove whitespace on update' do
      card = create(:card)
      card.update(original_text: '   d', translated_text: 'h   ')
      expect(card.original_text).to eq('d')
      expect(card.translated_text).to eq('h')
    end
  end
end
