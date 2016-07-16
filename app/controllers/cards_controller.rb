class CardsController < ApplicationController
  before_action :require_login
  before_action :set_card, only: [:edit, :update, :destroy]


  def index
    @cards = current_user.decks.find(params[:deck_id]).cards.all
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.decks.find(params[:deck_id]).cards.new(card_params)

    if @card.save
      redirect_to deck_cards_path(params[:deck_id]), notice: I18n.t('controllers.card.create')
    else
      render :new
    end
  end

  def update
    @card.update(card_params)

    if @card.save
      redirect_to deck_cards_path(@card.deck_id), notice: I18n.t('controllers.card.update')
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to deck_cards_path(@card.deck_id), notice: I18n.t('controllers.card.destroy')
  end

  private

  def set_card
    deck_id = Card.find(params[:id]).deck_id
    @card = current_user.decks.find(deck_id).cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, 
                                 :translated_text, 
                                 :image,
                                 :remote_image_url,
                                 :deck_id)
  end
end
