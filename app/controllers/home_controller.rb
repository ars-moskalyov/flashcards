class HomeController < ApplicationController
  def index
    @card = Card.review
  end

  def create
    @card = Card.find(home_params[:card_id])
    if @card.original_text.mb_chars.downcase == home_params[:answer].strip.mb_chars.downcase
      @card.update(review_date: Time.now + 3.days)
      redirect_to root_path, notice: t('controllers.home.correct')
    else
      redirect_to root_path, notice: t('controllers.home.wrong')
    end
  end

  private

  def home_params
    params.require(:home).permit(:answer, :card_id)
  end
end
