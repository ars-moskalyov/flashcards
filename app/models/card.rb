class Card < ApplicationRecord

  def view
    update(review_date: Time.now)
  end

end
