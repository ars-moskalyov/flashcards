class Card < ApplicationRecord
  belongs_to :deck
  has_one :user, through: :deck

  mount_uploader :image, ImageUploader

  before_validation :set_review_date, on: :create
  before_validation :remove_whitespace

  validates :deck, presence: true
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :texts_must_be_diffirent
  validates :check, inclusion: { in: 1..5 }
  validates :effort, inclusion: { in: 0..2 }

  scope :review, -> { where('review_date <= ?', Time.current).order("RANDOM()") }

  private

  def texts_must_be_diffirent
    if original_text && translated_text
      if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
        errors.add(:texts, I18n.t('activerecord.errors.messages.different_texts'))
      end
    end
  end

  def set_review_date
    self.review_date = Time.current
  end

  def remove_whitespace
    if original_text && translated_text
     self.original_text = self.original_text.strip
     self.translated_text = self.translated_text.strip
    end
  end
end
