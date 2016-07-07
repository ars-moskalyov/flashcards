class TrainerController < ApplicationController

  def review
    @card = Card.find(trainer_params[:card_id])
    if check_answer?
      @card.new_review_date!
      redirect_to root_path, notice: t('controllers.trainer.correct')
    else
      redirect_to root_path, notice: t('controllers.trainer.wrong')
    end
  end

  private

  def trainer_params
    params.require(:trainer).permit(:answer, :card_id)
  end

  def check_answer?
    @card.original_text.mb_chars.downcase == trainer_params[:answer].strip.mb_chars.downcase
  end
end
