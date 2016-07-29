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
      redirect_to decks_path, notice: t('.create')
    else
      render :new
    end
  end

  def update
    @deck.update(deck_params)

    if @deck.save
      redirect_to decks_path, notice: t('.update')
    else
      redirect_to edit_deck_path(@deck), alert: @deck.errors.full_messages.join('<br />')
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path, notice: t('.destroy')
  end

  def set_default
    current_user.update!(default_deck_id: params[:deck_id])
    redirect_to decks_path, notice: t('.default')
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title, 
                                 :description)
  end
end
