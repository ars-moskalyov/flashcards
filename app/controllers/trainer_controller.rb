class TrainerController < ApplicationController
  before_action :require_login
  
  def review
    @result = CheckAnswer.new(trainer_params[:card_id], trainer_params[:answer]).check
  end

  private

  def trainer_params
    params.require(:trainer).permit(:answer, :card_id)
  end
end
