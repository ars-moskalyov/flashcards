class Card < ApplicationRecord

  def view
    self.update(review_date: Time.now)
  end

end
