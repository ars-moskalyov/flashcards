class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  
  validates :user, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
