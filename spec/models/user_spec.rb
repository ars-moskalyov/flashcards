require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations tests' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end
  
  describe 'associations tests' do
    it { should have_many(:cards).dependent(:destroy) }
  end
end
