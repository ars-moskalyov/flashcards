class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :cards, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
