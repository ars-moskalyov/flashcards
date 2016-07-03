class CardsController < ApplicationController

  before_action :set_card, only: :show

  def index
    @cards = Card.all
  end

  def show
    @card.view
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_path
    else
      render :new
    end
  end


  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text,
                                 :translated_text,
                                 :review_date)
  end
end
