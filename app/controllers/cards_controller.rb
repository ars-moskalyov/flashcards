class CardsController < ApplicationController
  before_action :require_login
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_path, notice: I18n.t('controllers.card.create')
    else
      render :new
    end
  end

  def update
    @card.update(card_params)

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

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text,
                                 :translated_text,
                                 :user_id)
  end
end
