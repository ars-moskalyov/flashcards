class DecksController < ApplicationController
  before_action :require_login
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  def index
    @decks = current_user.decks
  end

  def new
    @deck = current_user.decks.new
  end

  def edit
  end

  def create
    @deck = current_user.decks.new(deck_params)

    if @deck.save
      redirect_to decks_path, notice: I18n.t('controllers.deck.create')
    else
      render :new
    end
  end

  def update
    @deck.update(deck_params)

    if @deck.save
      redirect_to decks_path, notice: I18n.t('controllers.deck.update')
    else
      render :edit
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path, notice: I18n.t('controllers.deck.destroy')
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title, :description)
  end
end
