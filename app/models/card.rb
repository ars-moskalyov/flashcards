class Card < ApplicationRecord
  before_validation :set_review_date

  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :texts_must_be_diffirent

  def view
    update(review_date: Time.now)
  end

  private

  def texts_must_be_diffirent
    if original_text.downcase == translated_text.downcase
      errors.add(:texts, 'must be different')
    end
  end

  def set_review_date
    self.review_date = Time.now + 3.days
  end
end