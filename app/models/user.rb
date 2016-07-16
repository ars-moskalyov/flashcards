class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :decks, dependent: :destroy

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

 # scope :default, -> { decks.find(default_deck).cards }
  def default
    decks.find(default_deck).cards
  end
end
