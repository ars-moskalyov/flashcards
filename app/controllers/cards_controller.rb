class CardsController < ApplicationController
  before_action :require_login
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = current_user.cards.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    download_image

    if @card.save
      redirect_to cards_path, notice: I18n.t('controllers.card.create')
    else
      render :new
    end
  end

  def update
    @card.update(card_params)
    download_image

    if @card.save
      redirect_to cards_path, notice: I18n.t('controllers.card.update')
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path, notice: I18n.t('controllers.card.destroy')
  end

  private

  def download_image
    if card_params[:remote_url]
      @card.download_image
    end
  end

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image, :remote_url)
  end
end
