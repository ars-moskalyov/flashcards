class User < ApplicationRecord
  authenticates_with_sorcery!
  
  has_many :cards, through: :decks
  has_many :decks, dependent: :destroy
  belongs_to :default_deck, class_name: 'Deck', foreign_key: "default_deck_id"

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :locale, presence: true
  validates_inclusion_of :locale, in: I18n.available_locales.map { |locale| locale.to_s }
  validates_inclusion_of :subscribe, in: [true, false]
  validates :name, presence: true

  def review_card
    if decks.exists? && default_deck_id
      default_deck.cards.review.first
    elsif decks.exists?
      decks.order("RANDOM()").first.cards.review.first
    end
  end

  def self.send_notification
    users = User.where(subscribe: true).joins(:cards).where('cards.review_date <= ?', Time.current).distinct!
    users.each do |user|
      NotificationsMailer.pending_cards_notification(user).deliver_now  
    end
  end
end
