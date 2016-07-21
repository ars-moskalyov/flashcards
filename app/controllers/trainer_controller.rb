class TrainerController < ApplicationController
  before_action :require_login
  
  def review
    result = CheckAnswer.new(trainer_params[:card_id], trainer_params[:answer])
    if result.success?
      redirect_to root_path, notice: t('controllers.trainer.correct')
    else
      redirect_to root_path, notice: t('controllers.trainer.wrong')
    end
  end

  private

  def trainer_params
    params.require(:trainer).permit(:answer, :card_id)
  end
end
