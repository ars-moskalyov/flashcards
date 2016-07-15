class Card < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader
  
  attr_accessor :remote_url

  before_validation :set_review_date, on: :create
  before_validation :remove_whitespace

  validates :user, presence: true
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :texts_must_be_diffirent

  scope :review, -> (user) { where('review_date <= ? AND user_id = ?', Time.now, user).order("RANDOM()") }

  def download_image
    self.remote_image_url = remote_url
  end

  def check_answer(answer)
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
    if original_text && translated_text
      if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
        errors.add(:texts, 'must be different')
      end
    end
  end

  def set_review_date
    self.review_date = Time.now + 3.days
  end

  def remove_whitespace
    if original_text && translated_text
     self.original_text = self.original_text.strip
     self.translated_text = self.translated_text.strip
    end
  end
end
