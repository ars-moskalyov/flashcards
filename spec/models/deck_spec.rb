require 'rails_helper'

RSpec.describe Deck, type: :model do
  it 'should have valid factory' do
    expect(build(:deck)).to be_valid
  end

  describe 'validation tests' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :user }
  end

  describe 'associations tests' do
    it { should belong_to :user }
    it { should have_many(:cards).dependent(:destroy) }
  end
end
