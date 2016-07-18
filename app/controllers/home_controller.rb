class HomeController < ApplicationController
  def index
    if current_user
      @card = current_user.review_card
    end
  end
end
