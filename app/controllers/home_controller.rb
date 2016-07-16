class HomeController < ApplicationController
  def index
    if current_user
      if current_user.decks.exists?
        @card = current_user.review_card
      end
    end
  end
end
