require 'rails_helper'

describe CheckAnswer do

  describe '.check' do
    context 'return' do
      it 'card' do
        @card = create(:card)
        result = CheckAnswer.new(@card.id, 'jjj').check
        expect(result[:card]).to eq(@card)
      end

      it 'answer' do
        @card = create(:card)
        result = CheckAnswer.new(@card.id, 'jjj').check
        expect(result[:answer]).to eq('jjj')
      end

      { correct: ['rabbit', 0], mistake: ['rabit', 1], wrong: ['wolf', 6] }.each do |k, v|
        it "#{k}" do
          @card = create(:card, original_text: 'rabbit')
          result = CheckAnswer.new(@card.id, v[0]).check
          expect(result[:err]).to eq(v[1])
        end
      end
    end

    context 'incorrect answer' do
      it 'third attempt and check > 1' do
        @card = create(:card, check: 4, effort: 2)
        CheckAnswer.new(@card.id, 'jjj').check
        @card.reload
        expect(@card.effort).to eq(0)
        expect(@card.check).to eq(3)
      end

      it 'third attempt and check = 1' do
        @card = create(:card, check: 1, effort: 2)
        CheckAnswer.new(@card.id, 'jjj').check
        @card.reload
        expect(@card.effort).to eq(0)
        expect(@card.check).to eq(1)
      end

      it 'second attempt' do
        @card = create(:card, check: 1, effort: 1)
        CheckAnswer.new(@card.id, 'jjj').check
        @card.reload
        expect(@card.effort).to eq(2)
        expect(@card.check).to eq(1)
      end
    end

    context 'correct answer' do
      it 'check = 5' do
        @card = create(:card, original_text: 'zzz', check: 5)
        CheckAnswer.new(@card.id, 'zzz').check
        @card.reload
        date = (Time.current + 1.month).strftime('%Y-%m-%d')
        expect(@card.review_date.to_s).to match(date)
      end

      it 'check < 5' do
        @card = create(:card, original_text: 'zzz', check: 3, effort: 2)
        CheckAnswer.new(@card.id, 'zzz').check
        @card.reload
        expect(@card.effort).to eq(0)
        expect(@card.check).to eq(4)
      end
    end

    context 'correct answer with mistake' do
      it 'check = 3' do
        @card = create(:card, original_text: 'lorem', check: 3)
        CheckAnswer.new(@card.id, 'lorAm').check
        @card.reload
        expect(@card.check).to eq(4)
      end
    end
  end
end
