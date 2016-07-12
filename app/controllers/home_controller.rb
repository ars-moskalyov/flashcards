class HomeController < ApplicationController
  def index
    if current_user
      @card = Card.review(current_user.id)
    end
  end
end
