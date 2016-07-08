class HomeController < ApplicationController
  def index
    @card = Card.review
  end
end
