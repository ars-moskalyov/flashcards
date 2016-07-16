require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validations tests' do
    subject { create(:user) }
    it { should validate_length_of(:password).is_at_least(5) }
    it { should validate_confirmation_of :password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
  
  describe 'associations tests' do
    it { should have_many(:decks).dependent(:destroy) }
  end

  describe '#review_card' do
    before(:each) do
      @user = create(:user)
      deck1 = create(:deck, user_id: @user.id)
      deck2 = create(:deck, user_id: @user.id)
      create(:card_for_review, deck_id: deck1.id, original_text: 'deck1')
      create(:card_for_review, deck_id: deck2.id, original_text: 'deck2')
    end

    it 'user have default deck' do
      @user.update!(default_deck: @user.decks.first.id)
      5.times do
        expect(@user.review_card.original_text).to eq 'deck1'
      end
    end

    it "user don't have default deck" do
      x = 0
      15.times do
        if @user.review_card.original_text == 'deck1'
          x += 1
        end
      end
      expect(x).to_not eq 15
    end
  end
end
