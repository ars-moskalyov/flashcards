class HomeController < ApplicationController
  def index
    if current_user
      @card = current_user.decks.order("RANDOM()").first.cards.order("RANDOM()") #!!!!!!!!!!
    end
  end
end
