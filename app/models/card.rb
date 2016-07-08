class Card < ApplicationRecord
  before_validation :set_review_date, on: :create

  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :texts_must_be_diffirent

  scope :review, lambda { where('review_date >= ?', Time.now).order("RANDOM()") }

  def chek_answer(answer)
    if original_text.mb_chars.downcase == answer.strip.mb_chars.downcase
      touch_review_date!
      Result.new(:ok)
    else
      Result.new
    end
  end

  private

  Result = Struct.new(:status) do 
    def success?
      status == :ok
    end
  end

  def touch_review_date!
    update(review_date: Time.now + 3.days)
  end

  def texts_must_be_diffirent
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:texts, 'must be different')
    end
  end

  def set_review_date
    self.review_date = Time.now + 3.days
  end
end
