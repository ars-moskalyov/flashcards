class Card < ApplicationRecord
  # before_validation :set_review_date, on: :create

  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :texts_must_be_diffirent

  scope :review, lambda { where('review_date <= ?', Time.now).order("RANDOM()").first }

  def self.new(*args, &block)
    card = super(*args, &block)
    card.review_date = Time.now + 3.days
    card
  end

  def set_review_date
    update(review_date: Time.now + 3.days)
  end

  private

  def texts_must_be_diffirent
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:texts, 'must be different')
    end
  end
end
