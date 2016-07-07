class HomeController < ApplicationController
  def index
    @card = Card.review
  end

  def create
    @card = Card.find(home_params[:card_id])
    if check_answer?
      @card.set_review_date
      redirect_to root_path, notice: t('controllers.home.correct')
    else
      redirect_to root_path, notice: t('controllers.home.wrong')
    end
  end

  private

  def check_answer?
    @card.original_text.mb_chars.downcase == home_params[:answer].strip.mb_chars.downcase
  end

  def home_params
    params.require(:home).permit(:answer, :card_id)
  end
end
