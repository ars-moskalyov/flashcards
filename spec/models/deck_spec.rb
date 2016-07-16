require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe 'associations tests' do
    it { should belong_to :user }
    it { should have_many(:cards).dependent(:destroy) }
  end
end
