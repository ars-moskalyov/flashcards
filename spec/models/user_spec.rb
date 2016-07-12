require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations tests' do
    subject { create(:user) }
    it { should validate_length_of(:password).is_at_least(5) }
    it { should validate_confirmation_of :password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
  
  describe 'associations tests' do
    it { should have_many(:cards).dependent(:destroy) }
  end
end
