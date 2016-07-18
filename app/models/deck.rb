class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  
  validates :user, presence: true
  validates :title, presence: true
  validates :description, presence: true

  after_destroy :remove_default

  private

  def remove_default
    if user.default_deck_id == id
      user.update(default_deck_id: '')
    end
  end
end
