class User < ApplicationRecord
  authenticates_with_sorcery!
  
  has_many :decks, dependent: :destroy

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  def review_card
    if default_deck_id
      decks.find(default_deck_id).cards.review.first
    else
      decks.order("RANDOM()").first.cards.review.first
    end
  end
end
