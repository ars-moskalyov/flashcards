class HomeController < ApplicationController
  def index
    if current_user
      if current_user.default_deck
        @card = current_user.default.review
      else
        @card = current_user.decks.order("RANDOM()").first.cards.review
      end
    end
  end
end
