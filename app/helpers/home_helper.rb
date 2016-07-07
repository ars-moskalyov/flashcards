module HomeHelper

  def cards_to_review?
    @card.class == Card
  end
end
