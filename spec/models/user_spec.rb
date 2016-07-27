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
    it { should validate_presence_of :name }
    it { should validate_presence_of :locale }
    it { should validate_presence_of :subscribe }
  end
  
  describe 'associations tests' do
    it { should have_many(:decks).dependent(:destroy) }
    it { should have_many(:cards) }
  end

  describe '#review_card' do
    before(:each) do
      @user = create(:user)
      deck1 = create(:deck, user_id: @user.id)
      @deck2 = create(:deck, user_id: @user.id)
      create(:card, deck_id: deck1.id, original_text: 'deck1')
      create(:card, deck_id: @deck2.id, original_text: 'deck2')
      allow(@user.decks).to receive(:order).with("RANDOM()") { [@deck2] }
    end

    it 'user have default deck' do
      @user.update!(default_deck_id: @user.decks.first.id)
      expect(@user.review_card.original_text).to eq 'deck1'
    end

    it "user don't have default deck" do
      @card = @user.review_card
      expect(@card.deck).to eq(@deck2)
      expect(@card.original_text).to eq 'deck2'
    end
  end

  describe '.send_notification' do
    it 'card to review exists' do
      card = create(:card)
      expect(User.send_notification).to eq([card.deck.user])
    end

    it 'card to review not exists' do
      expect(User.send_notification).to eq([])
    end
  end
end
