require 'rails_helper'

describe CheckAnswer do
  before(:each) do
    @card = create(:card, original_text: 'zzz')
  end

  context '.success?' do
    it 'correct answer' do
      c = CheckAnswer.new(@card.id, 'zzz')
      expect(c.success?).to be_truthy
    end

    it 'wrong answer' do
      c = CheckAnswer.new(@card.id, 'xxx')
      expect(c.success?).to be_falsey
    end
  end

  describe '#check' do
    context 'incorrect answer' do
      it 'third attempt and check > 1' do
        @card = create(:card, check: 4, effort: 2)
        c = CheckAnswer.new(@card.id, 'jjj')
        c.send(:check)
        @card.reload
        expect(@card.effort).to eq(0)
        expect(@card.check).to eq(3)
      end

      it 'third attempt and check = 1' do
        @card = create(:card, check: 1, effort: 2)
        c = CheckAnswer.new(@card.id, 'jjj')
        c.send(:check)
        @card.reload
        expect(@card.effort).to eq(0)
        expect(@card.check).to eq(1)
      end

      it 'second attempt' do
        @card = create(:card, check: 1, effort: 1)
        c = CheckAnswer.new(@card.id, 'jjj')
        c.send(:check)
        @card.reload
        expect(@card.effort).to eq(2)
        expect(@card.check).to eq(1)
      end
    end

    context 'correct answer' do
      it 'check = 5' do
        @card = create(:card, original_text: 'zzz', check: 5)
        c = CheckAnswer.new(@card.id, 'zzz')
        c.send(:check)
        @card.reload
        date = (Time.current + 1.month).strftime('%Y-%m-%d')
        expect(@card.review_date.to_s).to match(date)
      end

      it 'check < 5' do
        @card = create(:card, original_text: 'zzz', check: 3, effort: 2)
        c = CheckAnswer.new(@card.id, 'zzz')
        c.send(:check)
        @card.reload
        expect(@card.effort).to eq(0)
        expect(@card.check).to eq(4)
      end
    end
  end
end
